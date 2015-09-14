

import java.io.Serializable;

public class Employe extends Personne implements Serializable
{
    private double salaire;
    public Employe(String nom,String prenom,double salaire)
    {
    	super(nom,prenom);
    	this.salaire=salaire;
    }
    
    public Employe(String nom,String prenom,int age,double salaire)
    {
    	super(nom,prenom,age);
    	this.salaire=salaire;
    }
 
    public void setSalaire(double salaire)
    {
        this.salaire=salaire;    	
    }
    
    public double getSalaire()
    {
        return(salaire);	
    }
    
    public String toString()
    {
       return(super.toString()+"\nsalaire = "+salaire+"DH");	
    }

}
