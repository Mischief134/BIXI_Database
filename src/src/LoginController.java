import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.paint.Color;

public class LoginController implements Initializable {
	
	@FXML
	private TextField username;
	
	@FXML
	private PasswordField password;

	@FXML
	private Label incorrectPassowordLabel;
	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		assert username != null : "fx:id=\"username\" was not injected: check your FXML file 'LoginScene.fxml'.";
		assert password != null : "fx:id=\"password\" was not injected: check your FXML file 'LoginScene.fxml'.";
	}


	public void connectToDatabase(ActionEvent event) throws SQLException, IOException {
		boolean exceptionThrown = false;

		try {
			DatabaseManager.connectDatabase(username.getText(), password.getText());
		}catch(Exception e){
			exceptionThrown = true;
			incorrectPassowordLabel.setText("Failed to connect to database.");
			incorrectPassowordLabel.setTextFill(Color.web("red"));
		}

		if(!exceptionThrown) {
			SceneManager.changeScene(event, "MenuScene.fxml");
		}
	}

}
