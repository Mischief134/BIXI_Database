import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;

import javax.xml.transform.Result;
import java.io.IOException;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.ResourceBundle;

public class ManageTransactionsController implements Initializable {

    @FXML
    private Label prompt;

    @FXML
    private Button backBtn;

    @FXML
    private ComboBox<String> plans;

    @FXML
    private MenuButton menuBtn;

    @FXML
    private MenuItem searchUserBtn;

    @FXML
    private MenuItem addTransactionBtn;

    @FXML
    private DatePicker datePicker;

    @FXML
    private TextField userEmailField;

    @FXML
    private TextField subtotalField;

    @FXML
    private TableView transactionTable;

    @FXML
    private TableColumn name;

    @FXML
    private TableColumn subtotal;

    private ObservableList<Transaction> data = FXCollections.observableArrayList();

    private ObservableList<String> plansList = FXCollections.observableArrayList();

    private void populatePlansComboBox() throws SQLException{
        String sql =
            "SELECT name FROM plans;";
        ResultSet resultSet = DatabaseManager.runQuery(sql);
        while(resultSet.next()){
            plansList.add(resultSet.getString("name"));
        }
        resultSet.close();
    }

    private int getCurrentTransactionId() throws SQLException{
        String sql =
                "SELECT * FROM transactions ORDER BY tranid desc LIMIT 1;";
        ResultSet resultSet = DatabaseManager.runQuery(sql);
        resultSet.next();
        return resultSet.getInt("tranid");
    }

    @Override
    @SuppressWarnings("unchecked")
    public void initialize(URL location, ResourceBundle resources) {
        transactionTable.setItems(data);
        try{
            populatePlansComboBox();
        }catch(SQLException e){
            e.printStackTrace();
        }
        plans.setItems(plansList);
    }


    public void searchUserOnClick(ActionEvent e) throws SQLException{
        String sql =
                "SELECT transactions.name, transactions.date, transactions.subtotal " +
                "FROM transactions " +
                "INNER JOIN users " +
                "ON users.userid = transactions.userid " +
                "WHERE users.email = '" + userEmailField.getText() + "';";
        ResultSet resultSet = DatabaseManager.runQuery(sql);

        if(resultSet.next()){
            do{
                String name = resultSet.getString("name");
                String date = resultSet.getString("date");
                float subtotal = resultSet.getFloat("subtotal");

                data.add(new Transaction(name, date, subtotal));
            }while(resultSet.next());
        }else{
            prompt.setText("User: " + userEmailField.getText() + " doesn't exist!");
        }

        resultSet.close();
    }

    public void addTransaction(ActionEvent e) throws SQLException{
        String sql;
        ResultSet resultSet;

        sql = "SELECT userid FROM users WHERE email = '" + userEmailField.getText() + "';";
        resultSet = DatabaseManager.runQuery(sql);
        if(!resultSet.next()){
            return;
        }

        int userid = resultSet.getInt("userid");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
        String date = datePicker.getValue().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        Date parsedDate;
        try {
            parsedDate = dateFormat.parse(date + " 00:00:00.000");
        }catch(ParseException ex){
            ex.printStackTrace();
            return;
        }
        int tranid = getCurrentTransactionId() + 1;
        Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());
        sql =   "INSERT INTO transactions VALUES(" +
                tranid + ", " +
                userid + ", " +
                "'" + plans.getValue() + "', " +
                "1, " +
                "'" + timestamp + "', " +
                "" + subtotalField.getText()  +
                ") ;";
        DatabaseManager.runUpdate(sql);
        resultSet.close();

        data.add(new Transaction(plans.getValue(), date,  Float.parseFloat(subtotalField.getText())));

    }



    public void back(ActionEvent e) throws IOException{
        SceneManager.changeScene(e, "MenuScene.fxml");
    }
}
