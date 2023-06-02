package syy.Servlet;

import syy.Bean.All;
import syy.util.DbUtils;
import syy.util.JsonUtils;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "modifyServlet", value = "/modifyServlet")
public class modifyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        String workerCode = request.getParameter("workerCode");
        String sql = "select * from WorkerInfo where workerCode=" + "'" + workerCode + "'";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    All all  = new All(rs.getString(2),rs.getString(3),rs.getString(4),
                            rs.getString(5),rs.getDate(6),rs.getString(7),
                            rs.getString(8),rs.getString(9),rs.getString(10),rs.getObject(11),
                            rs.getString(12));
                    response.getWriter().write(JsonUtils.objectToJson(all));
                }
            } catch (Exception inEx) {
                inEx.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

