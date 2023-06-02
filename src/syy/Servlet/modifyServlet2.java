package syy.Servlet;

import syy.Bean.Worker;
import syy.util.DbUtils;
import syy.util.JsonUtils;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "modifyServlet2", value = "/modifyServlet2")
public class modifyServlet2 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        int flag=0;
        String initCode = request.getParameter("initCode");
        String workerCode = request.getParameter("workerCode");
        if(!initCode.equals(workerCode)){
            String sql1 = "select * from WorkerInfo where workerCode=" + "'" + workerCode + "'";
            try (Connection conn = DbUtils.getConnection();
                 PreparedStatement st = conn.prepareStatement(sql1)) {
                try (ResultSet rs = st.executeQuery()) {
                    while (rs.next()) {
                        flag=1;
                        System.out.println("有重复");
                        String str = "{\"flag\":\"true\"}";
                        response.getWriter().write(str);
                    }
                }catch (Exception ex){
                    ex.printStackTrace();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
            if(flag==0){
                String siteName = request.getParameter("siteName");
                String workerName = request.getParameter("workerName");
                String workerSex = request.getParameter("workerSex");
                String workerBirthday = request.getParameter("workerBirthday");
                String workerAddress = request.getParameter("workerAddress");
                String workerPhone = request.getParameter("workerPhone");
                String workerJob = request.getParameter("workerJob");
                String workerPosition = request.getParameter("workerPosition");
                String registerTime = request.getParameter("registerTime");
                String workerPhoto = request.getParameter("workerPhoto");
                String sql = "update WorkerInfo set siteName=?,workerCode=?,workerName=?,workerSex=?,workerBirthday=?,workerAddress=?,workerPhone=?,workerJob=?,workerPosition=?,registerTime=?,workerPhoto=? where workerCode=" + "'" + initCode + "'";

                try (Connection conn = DbUtils.getConnection();
                     PreparedStatement st = conn.prepareStatement(sql)) {
                    st.setString(1,siteName);
                    st.setString(2,workerCode);
                    st.setString(3,workerName);
                    st.setString(4,workerSex);
                    st.setDate(5, Date.valueOf(workerBirthday));
                    st.setString(6,workerAddress);
                    st.setString(7,workerPhone);
                    st.setString(8,workerJob);
                    st.setString(9,workerPosition);
                    st.setTimestamp(10, Timestamp.valueOf(registerTime));
                    st.setString(11,workerPhoto);
                    int ret = st.executeUpdate();

                } catch (Exception e) {
                    e.printStackTrace();
                }
                String sql2 = "select * from WorkerInfo";
                List<Worker> workerList = new ArrayList<>();
                try (Connection conn = DbUtils.getConnection();
                     PreparedStatement st1 = conn.prepareStatement(sql2)) {
                    try (ResultSet rs = st1.executeQuery()) {
                        while (rs.next()) {
                            Worker worker  = new Worker(rs.getString(4),rs.getString(3),rs.getString(2),
                                    rs.getDate(6),rs.getObject(11));
                            workerList.add(worker);
                        }
                    } catch (Exception inEx) {
                        inEx.printStackTrace();
                    }
                }catch (Exception e) {
                    e.printStackTrace();
                }
                response.getWriter().write(JsonUtils.objectToJson(workerList));
        }
    }
}
