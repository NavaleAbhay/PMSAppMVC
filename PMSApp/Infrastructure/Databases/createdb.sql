        -- Active: 1678339848098@@127.0.0.1@3306@pms

        DROP DATABASE IF EXISTS PMS;
        CREATE DATABASE PMS;
        USE PMS;

        CREATE TABLE users (
        id INT PRIMARY KEY AUTO_INCREMENT,
        fullname VARCHAR(40) NOT NULL,
        email VARCHAR(25) NOT NULL,
        contactnumber VARCHAR(15),
        imageurl VARCHAR(50),
        createdat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
        CREATE TABLE credentials (
        id INT PRIMARY KEY AUTO_INCREMENT,
        username VARCHAR(50) NOT NULL UNIQUE,
        userid INT UNIQUE,
        password VARCHAR(25) NOT NULL,
        CONSTRAINT fk_credentials_users FOREIGN KEY users(userid) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
        );

        CREATE TABLE roles (
        id INT PRIMARY KEY AUTO_INCREMENT,
        rolename VARCHAR(50) NOT NULL
        );

        CREATE TABLE userroles (
        id INT PRIMARY KEY AUTO_INCREMENT,
        userid INT,
        roleid INT,
        CONSTRAINT fk_userroles_users FOREIGN KEY users(userid) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT fk_userroles_roles  FOREIGN KEY roles(roleid) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE CASCADE
        );
        CREATE TABLE employees(
                id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                userid INT NOT NULL UNIQUE,
                hiredate DATETIME,
                department VARCHAR(100),
                position VARCHAR(100),
                reportingid INT,
                CONSTRAINT fk_employees FOREIGN KEY(reportingid) REFERENCES employees(id) ON UPDATE CASCADE ON DELETE CASCADE,
                CONSTRAINT fk_employees_users FOREIGN KEY(userid) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
                salary double NOT NULL
        );
        
        CREATE TABLE projects(
                id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                title VARCHAR(40),
                startdate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                enddate DATETIME,
                description TEXT,
                teammanagerid INT NOT NULL,
                CONSTRAINT fk_employees_projects FOREIGN KEY(teammanagerid) REFERENCES employees(id) ON UPDATE CASCADE ON DELETE CASCADE,
                status enum(
                        'notstarted',
                        'inprogress',
                        'completed') DEFAULT 'notstarted'
        );

        --     CREATE TABLE members(
        --             id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        --             membership VARCHAR(20),
        --             membershipdate DATETIME,
        --             projectid INT NOT NULL,
        --             CONSTRAINT fk_projects_projectmembers FOREIGN KEY (projectid) REFERENCES projects(id) ON UPDATE CASCADE ON DELETE CASCADE,
        --             employeeid INT NOT NULL,
        --             CONSTRAINT fk_employee_projectmembers FOREIGN KEY(employeeid) REFERENCES employees(id) ON UPDATE CASCADE ON DELETE CASCADE
        --     );

        CREATE TABLE projectallocations(
                id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                membership VARCHAR(20),
                assigndate DATETIME,
                releasedate DATETIME default null,
                status enum('yes','no') default 'yes' ,
                projectid INT NOT NULL,
                CONSTRAINT fk_projects_project1 FOREIGN KEY (projectid) REFERENCES projects(id) ON UPDATE CASCADE ON DELETE CASCADE,
                employeeid INT NOT NULL,
                CONSTRAINT fk_employee_projectmembers1 FOREIGN KEY(employeeid) REFERENCES employees(id) ON UPDATE CASCADE ON DELETE CASCADE
        );

        CREATE TABLE activitytypes(
                id INT PRIMARY KEY AUTO_INCREMENT,
                activitytype VARCHAR(40) NOT NULL UNIQUE
        );

        CREATE TABLE activities(
                id INT PRIMARY KEY AUTO_INCREMENT,
                title VARCHAR(500) NOT NULL,
                --     activitytype ENUM("userstory","task","bug","issues","meeting","learning","mentoring","other"),
                activitytypeid INT NOT NULL,
                priority ENUM('Low', 'Medium', 'High') DEFAULT 'Medium',
                description VARCHAR(400),
                projectid INT NOT NULL,
                assignedto INT NOT NULL, 
                assignedby INT NOT NULL,
                createddate DATETIME NOT NULL,
                assigneddate DATETIME,
                startdate DATETIME,
                duedate DATETIME,
                status ENUM ( 'todo','inprogress','completed') DEFAULT 'todo' , 
                CONSTRAINT fk_activitiess_members FOREIGN KEY (assignedby) REFERENCES employees(id) ON UPDATE CASCADE ON DELETE CASCADE,
                CONSTRAINT fk_activities_members2 FOREIGN KEY (assignedto) REFERENCES employees(id) ON UPDATE CASCADE ON DELETE CASCADE,
                CONSTRAINT fk_activities_projects FOREIGN KEY (projectid) REFERENCES projects(id) ON UPDATE CASCADE ON DELETE CASCADE,
                CONSTRAINT fk_activities_activitytypes FOREIGN KEY (activitytypeid) REFERENCES activitytypes(id) ON UPDATE CASCADE ON DELETE CASCADE
        );

        CREATE TABLE sprints(
                id INT PRIMARY KEY AUTO_INCREMENT,
                title VARCHAR(40) NOT NULL,  
                startdate DATETIME NOT NULL,
                enddate DATETIME NOT NULL,
                goal VARCHAR(200)
        );

        CREATE TABLE sprintactivities(
                id INT PRIMARY KEY AUTO_INCREMENT,
                sprintid INT NOT NULL,
                activityid INT NOT NULL,
                CONSTRAINT fk_sprints FOREIGN KEY (sprintid) REFERENCES sprints(id) ON UPDATE CASCADE ON DELETE CASCADE,
                CONSTRAINT fk_activity FOREIGN KEY (activityid) REFERENCES activities(id) ON UPDATE CASCADE ON DELETE CASCADE
        );

        CREATE TABLE timesheets(
                id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
                timesheetdate DATETIME ,
                status ENUM ( 
                        'inprogress',
                        'submitted',
                        'approved',
                        'rejected'
                        ) DEFAULT 'inprogress', 
                statuschangeddate DATETIME DEFAULT  CURRENT_TIMESTAMP,
                employeeid INT NOT NULL,
                CONSTRAINT fk_timesheets_taskallocations FOREIGN KEY(employeeid) REFERENCES employees(id) ON UPDATE CASCADE ON DELETE CASCADE
        );

        CREATE TABLE timesheetentries(
                id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
                work VARCHAR(150) NOT NULL,
                activityid INT NOT NULL,
                -- workcategory ENUM("userstory","task","bug","issues","meeting","learning","mentoring","break","clientcall","other"),
                description VARCHAR(225),
                fromtime TIME,
                totime TIME,
                timesheetid INT NOT NULL,
                CONSTRAINT fk_timesheets_timesheetentries FOREIGN KEY(timesheetid) REFERENCES timesheets(id) ON UPDATE CASCADE ON DELETE CASCADE,
                CONSTRAINT fk_timesheets_activitytypes FOREIGN KEY(activityid) REFERENCES activitytypes(id) ON UPDATE CASCADE ON DELETE CASCADE
        );

        CREATE TABLE comments (
        id INT PRIMARY KEY AUTO_INCREMENT,
        activityid INT,
        employeeid INT NOT NULL,
        commenttext TEXT,
        timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_activities_comments FOREIGN KEY(activityid) REFERENCES activities(id) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT fk_employees_comments FOREIGN KEY(employeeid) REFERENCES employees(id) ON UPDATE CASCADE ON DELETE CASCADE
        );

        CREATE TABLE attachments (
        id INT PRIMARY KEY AUTO_INCREMENT,
        activityid INT,
        employeeid INT,
        filename VARCHAR(255) NOT NULL,
        filepath VARCHAR(255) NOT NULL,
        uploaddate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT fk_activities_attachments FOREIGN KEY(activityid) REFERENCES activities(id) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT fk_aemployees_attachments FOREIGN KEY (employeeid) REFERENCES employees(id)
        );


        SELECT * FROM activities;