package syy.Servlet;

import syy.Bean.Worker;
import syy.util.DbUtils;
import syy.util.JsonUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "workinfosServlet", value = "/workinfosServlet")
public class workinfosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        String siteName = request.getParameter("siteName");
        String workerName = request.getParameter("workerName");
        String sql = "select * from WorkerInfo where siteName="+"'"+siteName+"'and workerName="+"'"+workerName+"'";
        List<Worker> workerList = new ArrayList<>();
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Worker worker  = new Worker(rs.getString(4),rs.getString(3),rs.getString(2),
                            rs.getDate(6),rs.getObject(11));
                    workerList.add(worker);
                }
            } catch (Exception inEx) {
                inEx.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
//                    System.out.println(JsonUtils.objectToJson(workerList));
        response.getWriter().write(JsonUtils.objectToJson(workerList));
    }
}
