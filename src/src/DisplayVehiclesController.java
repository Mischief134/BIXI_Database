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


public class DisplayVehiclesController implements Initializable {

    @FXML
    private Label prompt;

    @FXML
    private TableView vehicleTable;

    @FXML
    private TableColumn makeCol;

    @FXML
    private TableColumn modelCol;

    @FXML
    private TableColumn capacityCol;

    @FXML
    private TableColumn stateCol;

    @FXML
    private TableColumn type;

    @FXML
    private Button backButton;

    private final ObservableList<Vehicle> data = FXCollections.observableArrayList();

    private void populateData() throws SQLException {

        String sql = "SELECT * FROM vehicles WHERE vtype = 'regular car' OR vtype = 'luxury car';";
        ResultSet resultSet = DatabaseManager.runQuery(sql);

        if (resultSet.next()) {
            do {
                String model = resultSet.getString("model");
                String make = resultSet.getString("make");
                String vType = resultSet.getString("vType");
                String state = resultSet.getString("veh_state");
                int cap = resultSet.getInt("capacity");

                data.add(new Vehicle(make, model, state, cap, vType));
            } while (resultSet.next());
        }

        resultSet.close();
    }

    @Override
    @SuppressWarnings("unchecked")
    public void initialize(URL location, ResourceBundle resources) {
        vehicleTable.setItems(data);
        try {
            populateData();
        }catch (SQLException e){
            e.printStackTrace();
        }
    }

    public void back(ActionEvent e) throws IOException {
        SceneManager.changeScene(e, "MenuScene.fxml");
    }

}
