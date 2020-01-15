import javafx.event.ActionEvent;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

import java.io.IOException;

public class SceneManager {

    public static void changeScene(ActionEvent e, String xmlPath) throws IOException {
        FXMLLoader loader = new FXMLLoader();
        loader.setLocation(Main.class.getResource(xmlPath));

        Scene scene = new Scene( (VBox) loader.load());
        Stage newStage = (Stage) ((Node) e.getSource()).getScene().getWindow();

        newStage.setScene(scene);
        newStage.show();
    }
}
