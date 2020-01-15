
import java.io.IOException;
import java.sql.SQLException;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class Main extends Application {

    private Stage primaryStage;
    private VBox rootLayout;


    private enum RunMode {
        DEFAULT,
        SKIP_LOGIN
    }

    //CHANGE THIS TO SKIP TO CERTAIN SCENES
    private RunMode runMode = RunMode.DEFAULT;

    private Thread.UncaughtExceptionHandler defaultUEH;

    // handler listener
    private Thread.UncaughtExceptionHandler _unCaughtExceptionHandler = new Thread.UncaughtExceptionHandler() {
        @Override
        public void uncaughtException(Thread thread, Throwable ex) {
            ex.printStackTrace();
            if (DatabaseManager.isConnected()) {
                System.out.println("Don't worry, we disconnected from the database.");
                DatabaseManager.disconnect();
            }
        }
    };

    @Override
    public void start(Stage primaryStage) {
        defaultUEH = Thread.getDefaultUncaughtExceptionHandler();
        Thread.setDefaultUncaughtExceptionHandler(_unCaughtExceptionHandler);

        this.primaryStage = primaryStage;
        this.primaryStage.setTitle("RentrApp");

        initRootLayout();
    }

    @Override
    public void stop(){
        System.out.print("Application closed.");
        if (DatabaseManager.isConnected()) {
            System.out.print(" Disconnecting from database.");
            DatabaseManager.disconnect();
        }else{
            System.out.print(" Not disconnecting from database, was never connected\n");
        }
    }
    
    /**
     * Initializes the root layout.
     */
    public void initRootLayout() {
        try {
            String fxmlPath;

            switch(runMode){
                case SKIP_LOGIN:
                    fxmlPath = "MenuScene.fxml";
                    DatabaseManager.connectDatabase("cs421g10", "nuriIsCool");
                    break;

                default:
                    fxmlPath = "LoginScene.fxml";
                    break;
            }

            // Load root layout from fxml file.
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(Main.class.getResource(fxmlPath));
            rootLayout = loader.load();
           // btn = (Button) loader.load();
            // Show the scene containing the root layout.
            Scene scene = new Scene(rootLayout);
            
            primaryStage.setScene(scene);
            primaryStage.show();

        } catch (IOException e) {
            e.printStackTrace();
        }catch (SQLException e) {
            e.printStackTrace();
            DatabaseManager.disconnect();
        }
    }


    public static void main(String[] args) {
        launch(args);
    }
}