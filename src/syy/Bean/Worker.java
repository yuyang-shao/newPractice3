package syy.Bean;


public class Worker {
    private String workerName;
    private String workerCode;
    private String siteName;
    private Object workerBirthday;
    private Object registerTime;

    public String getWorkerName() {
        return workerName;
    }

    public void setWorkerName(String workerName) {
        this.workerName = workerName;
    }

    public String getWorkerCode() {
        return workerCode;
    }

    public void setWorkerId(String workerCode) {
        this.workerCode = workerCode;
    }

    public String getSiteName() {
        return siteName;
    }

    public void setSiteName(String siteName) {
        this.siteName = siteName;
    }

    public Object getWorkerBirthday() {
        return workerBirthday;
    }

    public void setWorkerBirthday(Object workerBirthday) {
        this.workerBirthday = workerBirthday;
    }

    public Object getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Object registerTime) {
        this.registerTime = registerTime;
    }

    public Worker(String workerName, String workerCode, String siteName, Object workerBirthday, Object registerTime) {
        this.workerName = workerName;
        this.workerCode = workerCode;
        this.siteName = siteName;
        this.workerBirthday = workerBirthday;
        this.registerTime = registerTime;
    }
}
