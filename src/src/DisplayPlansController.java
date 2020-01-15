import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;

import java.io.IOException;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class DisplayPlansController implements Initializable{

    @FXML
    private Label prompt;

    @FXML
    private Button back;

    @FXML
    private TableView planTable;

    @FXML
    private TableColumn name;

    @FXML
    private TableColumn price;

    private ObservableList<Plan> data = FXCollections.observableArrayList();

    private void populateTable() throws SQLException{
        String sql = "SELECT * FROM plans;";
        ResultSet resultSet = DatabaseManager.runQuery(sql);

        if (resultSet.next()) {
            do{
                String name = resultSet.getString("name");
                float price = resultSet.getFloat("price");
                data.add(new Plan(name, price));
            }while(resultSet.next());
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public void initialize(URL location, ResourceBundle resources) {
        planTable.setItems(data);

        try {
            populateTable();
        }catch (SQLException e){
            e.printStackTrace();
        }
    }

    public void back(ActionEvent e) throws IOException{
        SceneManager.changeScene(e, "VehiclesAndPlansScene.fxml");
    }
}
