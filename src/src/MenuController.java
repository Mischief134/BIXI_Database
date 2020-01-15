import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.Button;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class MenuController implements Initializable {

    @FXML
    private Button changePersonalInfoBtn;

    @FXML
    private Button displayVehiclesAndPlansBtn;

    @FXML
    private Button manageTransactionsBtn;

    @FXML
    private Button findClosestStationBtn;

    @FXML
    private Button getVehicleAvailabilityBtn;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        assert changePersonalInfoBtn != null : "fx:id=\"changePersonalInfoBtn\" was not injected: check your FXML file 'MenuScene.fxml'.";
        assert displayVehiclesAndPlansBtn!= null : "fx:id=\"displayVehiclesAndPlansBtn\" was not injected: check your FXML file 'MenuScene.fxml'.";
        assert manageTransactionsBtn != null : "fx:id=\"manageTransactionsBtn\" was not injected: check your FXML file 'MenuScene.fxml'.";
        assert findClosestStationBtn != null : "fx:id=\"findClosestStationBtn\" was not injected: check your FXML file 'MenuScene.fxml'.";
        assert getVehicleAvailabilityBtn != null : "fx:id=\"getVehicleAvailabilityBtn\" was not injected: check your FXML file 'MenuScene.fxml'.";
    }

    public void changePersonalInfo(ActionEvent e) throws IOException {
        SceneManager.changeScene(e, "PersonalInfoScene.fxml");
    }

    public void displayVehiclesAndPlans(ActionEvent e) throws IOException {
        SceneManager.changeScene(e, "VehiclesAndPlansScene.fxml");
    }
    public void displayVehicles(ActionEvent e) throws IOException {
        SceneManager.changeScene(e, "DisplayVehiclesScene.fxml");
    }

    public void manageTransactions(ActionEvent e) throws IOException {
        SceneManager.changeScene(e, "ManageTransactionsScene.fxml");
    }

    public void findClosestStation(ActionEvent e) throws IOException {
        SceneManager.changeScene(e, "ClosestStationScene.fxml");
    }

    public void getVehicleAvailability(ActionEvent e) throws IOException {
        SceneManager.changeScene(e, "GetVehicleAvailability.fxml");
    }
}
