import javafx.beans.property.SimpleFloatProperty;
import javafx.beans.property.SimpleStringProperty;

public class Transaction {

    private SimpleStringProperty name;
    private SimpleStringProperty date;
    private SimpleFloatProperty subtotal;

    public Transaction(String name, String date, float subtotal){
        this.name = new SimpleStringProperty(name);
        this.date = new SimpleStringProperty(date);
        this.subtotal = new SimpleFloatProperty(subtotal);
    }


    public float getSubtotal() {
        return subtotal.get();
    }

    public void setSubtotal(float subtotal) {
        this.subtotal.set(subtotal);
    }

    public String getDate() {
        return date.get();
    }

    public void setDate(String date) {
        this.date.set(date);
    }

    public String getName() {
        return name.get();
    }

    public void setName(String name) {
        this.name.set(name);
    }
}
