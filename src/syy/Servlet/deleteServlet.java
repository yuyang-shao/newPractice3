package syy.Servlet;

import syy.util.DbUtils;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "deleteServlet", value = "/deleteServlet")
public class deleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String workerCode = request.getParameter("workerCode");
        String sql = "delete WorkerInfo where workerCode=?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1,workerCode);
            int ret = st.executeUpdate();
        }catch (Exception e) {
            e.printStackTrace();
        }
        response.getWriter().write("success");

//        String sql1 = "select * from WorkerInfo";
//        List<Worker> workerList = new ArrayList<>();
//        try (Connection conn = DbUtils.getConnection();
//             PreparedStatement st1 = conn.prepareStatement(sql1)) {
//            try (ResultSet rs = st1.executeQuery()) {
//                while (rs.next()) {
//                    Worker worker  = new Worker(rs.getString(4),rs.getString(3),rs.getString(2),
//                            rs.getDate(6),rs.getObject(11));
//                    workerList.add(worker);
//                }
//            } catch (Exception inEx) {
//                inEx.printStackTrace();
//            }
//        }catch (Exception e) {
//            e.printStackTrace();
//        }
//        response.getWriter().write(JsonUtils.objectToJson(workerList));
    }
}
