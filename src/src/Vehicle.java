import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;

public class Vehicle {

    private final SimpleStringProperty make;
    private final SimpleStringProperty model;
    private final SimpleStringProperty state;
    private final SimpleIntegerProperty capactiy;
    private final SimpleStringProperty type;

    public Vehicle(String make, String model, String state, int capacity, String type){
        this.make = new SimpleStringProperty(make);
        this.model = new SimpleStringProperty(model);
        this.state = new SimpleStringProperty(state);
        this.capactiy = new SimpleIntegerProperty(capacity);
        this.type = new SimpleStringProperty(type);
    }


    public String getType() {
        return type.get();
    }
    public void setType(String fType) {
        type.set(fType);
    }

    public String getMake() {
        return make.get();
    }
    public void setMake(String fMake) {
        type.set(fMake);
    }

    public String getModel() {
        return model.get();
    }
    public void setModel(String fModel) {
        model.set(fModel);
    }

    public String getState() {
        return state.get();
    }
    public void setState(String fState){
        state.set(fState);
    }


    public int getCapactiy() {
        return capactiy.get();
    }
    public void setCapactiy(int fCapacity) {
        capactiy.set(fCapacity);
    }

}
