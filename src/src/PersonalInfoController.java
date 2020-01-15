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

public class PersonalInfoController implements Initializable {

    @FXML
    private TextField email;

    @FXML
    private Label prompt;

    @FXML
    private TableView userTable;

    @FXML
    private TableColumn firstNameCol;

    @FXML
    private TableColumn lastNameCol;

    @FXML
    private TableColumn ageCol;

    @FXML
    private TableColumn emailCol;

    @FXML
    private Button backButton;

    private final ObservableList<Person> data = FXCollections.observableArrayList();

    private void fetchAndDisplayUserInfo() throws SQLException{
        String sql =
                "SELECT firstname, lastname, age, email FROM users " +
                        "WHERE email = \'" + email.getText() + "\';";


        ResultSet resultSet = DatabaseManager.runQuery(sql);
        data.clear();

        if (resultSet.next()){
            do{
                String firstName = resultSet.getString("firstname");
                String lastName = resultSet.getString("lastname");
                int age = resultSet.getInt("age");
                String email = resultSet.getString("email");

                data.add(new Person(firstName, lastName, age, email));
                System.out.println("Added: " + firstName + " " + lastName + " " + age);
            }while(resultSet.next());
        }else {
            prompt.setText("No user with email \"" + email.getText() + "\" found.");

        }

        email.setText("");
        resultSet.close();
    }

    @Override
    @SuppressWarnings("unchecked")
    public void initialize(URL location, ResourceBundle resources) {
        userTable.setItems(data);
    }

    public void back(ActionEvent e) throws IOException {
        SceneManager.changeScene(e, "MenuScene.fxml");
    }

    /** Get the info about a user, should they exist.*/
    public void onEmailEnter(ActionEvent e) throws SQLException {
        fetchAndDisplayUserInfo();
    }
}
