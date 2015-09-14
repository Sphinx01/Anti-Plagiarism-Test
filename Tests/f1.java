package projetJava;
 
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
 
import javax.swing.JOptionPane;
import javax.swing.JTextField;
 
class Authentification implements ActionListener {
 
	//Objet pour se connecter à la base de données
	public Base b = new Base();
	public Connection conn;
 
	static JTextField user, mdp;
 
	//Objet PreparedStatement
    PreparedStatement statement = null;
    //Objet ResultSet
    ResultSet resultat = null;
 
	public Authentification() {
 
	}
 
	public void actionPerformed(ActionEvent ae)
	{
 
		String login = user.getText();
        String password = mdp.getText();
 
        b.ConnexionBD();
		conn = b.getConnect();
 
		//Manipulation
		try {
			//Création de la requête
			statement = conn.prepareStatement("SELECT password FROM utilisateurs WHERE login ='"+login+"'");
 
			resultat = statement.executeQuery();
 
			if(resultat.next())
			{
				String motDePasse = resultat.getString(1);
				if(motDePasse.equals(password))
				{
					JOptionPane.showMessageDialog(null,"Connexion réussie ! ","Success",JOptionPane.PLAIN_MESSAGE);
				}
				else {
					JOptionPane.showMessageDialog(null,"Mot de passe incorrect ! ","Error",1);
				}
			}
			else {
				JOptionPane.showMessageDialog(null,"Login incorrect ! ","Error",1);
			}
 
			//Récupération de la requête dans une variable
			resultat = statement.executeQuery();
 
			conn.close();
		}
		catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}
}
