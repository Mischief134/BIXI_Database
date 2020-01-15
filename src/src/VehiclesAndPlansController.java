import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class VehiclesAndPlansController implements Initializable{

    @FXML
    private Button vehiclesButton;

    @FXML
    private Button plansButton;

    @FXML
    private Button backBtn;

    @FXML
    private Label prompt;


    @Override
    public void initialize(URL location, ResourceBundle resources) {

    }

    public void showVehicles(ActionEvent e) throws IOException {
        SceneManager.changeScene(e, "DisplayVehiclesScene.fxml");
    }

    public void showPlans(ActionEvent e) throws IOException{
        SceneManager.changeScene(e, "DisplayPlansScene.fxml");
    }

    public void back(ActionEvent e) throws IOException{
        SceneManager.changeScene(e, "MenuScene.fxml");
    }
}
