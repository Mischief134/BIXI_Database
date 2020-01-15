import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;

import java.io.IOException;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class FavoriteStationController implements Initializable {

    @FXML
    private Label prompt;

    @FXML
    private Label favStation;

    @FXML
    private Button backButton;

    @FXML
    private TextField userEmailField;

    @FXML
    private TableView vehicles;

    @FXML
    private TableColumn capacity;

    @FXML
    private TableColumn model;

    @FXML
    private TableColumn make;

    @FXML
    private TableColumn type;

    private String promptBackup;

    private ObservableList<Vehicle> data = FXCollections.observableArrayList();

    private void populateVehicles(int stationId) throws SQLException{
        data.clear();
        String sql =
                "SELECT make, model, veh_state, capacity, vtype  FROM vehicles WHERE serialnb IN " +
                        "(SELECT trips.serialnb FROM trips WHERE trips.endsat = " + stationId + ");";
        ResultSet resultSet = DatabaseManager.runQuery(sql);
        while(resultSet.next()){
            data.add(new Vehicle(
                    resultSet.getString(1),
                    resultSet.getString(2),
                    resultSet.getString(3),
                    resultSet.getInt(4),
                    resultSet.getString(5)));
        }
        resultSet.close();
    }

    @SuppressWarnings("unchecked")
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        vehicles.setItems(data);
    }

    public void back(ActionEvent e) throws IOException {
        SceneManager.changeScene(e, "MenuScene.fxml");
    }

    public void onEmailEnter(ActionEvent e) throws SQLException {
        String sql1 = "Select userid from users Where email = "+ "'" + userEmailField.getText() + "';" ;

        ResultSet resultSet = DatabaseManager.runQuery(sql1);

        if(! resultSet.next()){
            promptBackup = prompt.getText();
            prompt.setText("User " + userEmailField.getText() + " not found.");
            return;
        }

        String userId = (resultSet.getString(1));
        prompt.setText(promptBackup);


        String sql2 = "SELECT sID FROM\n" +
                "(SELECT startsat as sID, count(startsat) as c\n" +
                "FROM trips\n" +
                "WHERE userId = "+ userId + "\n" +
                "GROUP BY startsat\n" +
                "\n" +
                "UNION\n" +
                "\n" +
                "SELECT endsat, count(endsat) \n" +
                "FROM trips\n" +
                "WHERE userId = "+ userId +" \n" +
                "GROUP BY endsat) ustations\n" +
                "GROUP BY sID\n" +
                "ORDER BY sum(c) DESC LIMIT 1;\n";

        ResultSet resultSet1 = DatabaseManager.runQuery(sql2);
        resultSet1.next();
        int sid  = (resultSet1.getInt(1));

        String sql3 = "SELECT name From stations Where sid = "+sid+";";

        ResultSet resultSet2 = DatabaseManager.runQuery(sql3);
        resultSet2.next();
        favStation.setText("Your Favorite Station: " + resultSet2.getString(1));

        populateVehicles(sid);
    }



}
