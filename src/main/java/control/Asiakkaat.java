package control;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import org.json.JSONObject;
import model.dao.Dao;
import model.Asiakas;

@WebServlet("/asiakkaat/*")
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Asiakkaat() {
		super();
		System.out.println("Asiakkaat.Asiakkaat()"); //for testing purposes
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doGet()"); //for testing purposes
		String pathInfo = request.getPathInfo();
		System.out.println("polku: " + pathInfo); //for testing purposes
		String hakusana = pathInfo.replace("/", "");
		Dao dao = new Dao();
		ArrayList<Asiakas> asiakkaat = dao.listaaKaikki(hakusana);
		System.out.println(asiakkaat);
		String strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString(); //put an object named asiakkaat, containing asiakkaat ArrayList, into a new JSONObject
		//write the JSONObject strJSON into the servlet HTML rajapinta:
		response.setContentType("application/json"); //the type of what we'll write is application/json
		PrintWriter out = response.getWriter(); //creating a PrintWriter
		out.println(strJSON);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPost()"); //for testing purposes
	}

	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPut()"); //for testing purposes
	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doDelete()"); //for testing purposes
	}
}