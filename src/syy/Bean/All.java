package syy.Bean;

public class All {
    private String siteName;
    private String workerCode;
    private String workerName;
    private String workerSex;
    private Object workerBirthday;
    private String workerAddress;
    private String workerPhone;
    private String workerJob;
    private String workerPosition;
    private Object registerTime;
    private String workerPhoto;

    public All(String siteName, String workerCode, String workerName, String workerSex, Object workerBirthday, String workerAddress, String workerPhone, String workerJob, String workerPosition, Object registerTime, String workerPhoto) {
        this.siteName = siteName;
        this.workerCode = workerCode;
        this.workerName = workerName;
        this.workerSex = workerSex;
        this.workerBirthday = workerBirthday;
        this.workerAddress = workerAddress;
        this.workerPhone = workerPhone;
        this.workerJob = workerJob;
        this.workerPosition = workerPosition;
        this.registerTime = registerTime;
        this.workerPhoto = workerPhoto;
    }

    public String getSiteName() {
        return siteName;
    }

    public void setSiteName(String siteName) {
        this.siteName = siteName;
    }

    public String getWorkerCode() {
        return workerCode;
    }

    public void setWorkerCode(String workerCode) {
        this.workerCode = workerCode;
    }

    public String getWorkerName() {
        return workerName;
    }

    public void setWorkerName(String workerName) {
        this.workerName = workerName;
    }

    public String getWorkerSex() {
        return workerSex;
    }

    public void setWorkerSex(String workerSex) {
        this.workerSex = workerSex;
    }

    public Object getWorkerBirthday() {
        return workerBirthday;
    }

    public void setWorkerBirthday(Object workerBirthday) {
        this.workerBirthday = workerBirthday;
    }

    public String getWorkerAddress() {
        return workerAddress;
    }

    public void setWorkerAddress(String workerAddress) {
        this.workerAddress = workerAddress;
    }

    public String getWorkerPhone() {
        return workerPhone;
    }

    public void setWorkerPhone(String workerPhone) {
        this.workerPhone = workerPhone;
    }

    public String getWorkerJob() {
        return workerJob;
    }

    public void setWorkerJob(String workerJob) {
        this.workerJob = workerJob;
    }

    public String getWorkerPosition() {
        return workerPosition;
    }

    public void setWorkerPosition(String workerPosition) {
        this.workerPosition = workerPosition;
    }

    public Object getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Object registerTime) {
        this.registerTime = registerTime;
    }

    public String getWorkerPhoto() {
        return workerPhoto;
    }

    public void setWorkerPhoto(String workerPhoto) {
        this.workerPhoto = workerPhoto;
    }
}
