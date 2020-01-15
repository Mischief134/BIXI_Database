import javafx.beans.property.SimpleFloatProperty;
import javafx.beans.property.SimpleStringProperty;

public class Plan {

    private final SimpleStringProperty name;
    private final SimpleFloatProperty price;

    public Plan(String name, float price){
        this.name = new SimpleStringProperty(name);
        this.price = new SimpleFloatProperty(price);
    }

    public String getName(){
        return name.get();
    }

    public void setName(String fName){
        name.set(fName);
    }

    public float getPrice(){
        return price.get();
    }

    public void setPrice(float fPrice){
        price.set(fPrice);
    }
}

