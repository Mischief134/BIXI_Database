import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;

import java.io.IOException;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class ClosestStationController implements Initializable {

    @FXML
    private Label prompt;

    @FXML
    private Label result;

    @FXML
    private Button backButton;

    @FXML
    private TextField latitude;

    @FXML
    private TextField longitude;

    @FXML
    private Button confirm;


    @Override
    public void initialize(URL location, ResourceBundle resources) {

    }

    public void back(ActionEvent e) throws IOException {
        SceneManager.changeScene(e, "MenuScene.fxml");
    }

    public void closestStation(ActionEvent e) throws SQLException{
        String sql = "SELECT stations.name, distance(stations.lat, stations.long, " + latitude.getText() +
        ", " + longitude.getText() + ") as dist FROM stations " +
        "ORDER BY dist " +
        "LIMIT 1;";
        ResultSet resultSet = DatabaseManager.runQuery(sql);

        if(resultSet.next()){
            do{
                String[] parts = resultSet.getString("name").split("/");

                result.setText("You should go to the corner of: " + parts[0] + "and" + parts[1]);
            }while(resultSet.next());
        }

        resultSet.close();
    }

}
