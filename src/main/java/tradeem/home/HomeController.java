//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 19.
//  Time: PM 01:07
//  To change this template use File | Settings | File Templates.
//
package tradeem.home;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HomeController
 */
@WebServlet("*.do")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri 			= request.getRequestURI();
		String contextPath 	= request.getContextPath();
		String command 		= uri.substring(contextPath.length());
		
		String viewPage 	= "/WEB-INF/views/home.jsp";
		String contentPage 	= "/WEB-INF/views/common/main.jsp";
		
		switch (command) {
			case "/home.do":
				contentPage = "/WEB-INF/views/common/main.jsp";
				break;
			case "/gameList.do":
				contentPage = "/WEB-INF/views/game/gameList.jsp";
				break;
			case "/cart.do":
				contentPage = "/WEB-INF/views/cart/cart.jsp";
				break;
			case "/bill.do":
				contentPage = "/WEB-INF/views/member/bill.jsp";
				break;
			case "/login.do":
				contentPage = "/WEB-INF/views/member/login.jsp";
				break;
			case "/sighin.do":
				contentPage = "/WEB-INF/views/member/signin.jsp";
				break;
			default :
				contentPage = "/WEB-INF/views/error/error404.jsp";
				break;
		}
		request.setAttribute("contentPage", contentPage);
		
		request.getRequestDispatcher(viewPage).forward(request, response);
	}

}
