--tao Database Session Context cho cac loai nhan vien
CREATE OR REPLACE PACKAGE set_title_ctx_pkg IS 
   PROCEDURE set_title; 
 END; 
 /
 CREATE OR REPLACE PACKAGE BODY set_title_ctx_pkg IS
   PROCEDURE set_title
   AS 
      title varchar2(20);
      countt INTEGER;
   BEGIN
      SELECT SYS_CONTEXT('USERENV', 'SESSION_USER') INTO title FROM DUAL;
      SELECT COUNT(TRUONGPHONG) INTO countt FROM PHONGBAN WHERE TRUONGPHONG = title;
      IF countt > 0
      THEN
        title := 'TruongPhong';
        DBMS_SESSION.SET_CONTEXT('emp_ctx', 'title', title);
      ELSE
      
        SELECT COUNT(TRUONGCHINHANH) INTO countt FROM CHINHANH WHERE TRUONGCHINHANH = title;
        IF (countt > 0) THEN
           title := 'TruongChiNhanh';
          DBMS_SESSION.SET_CONTEXT('emp_ctx', 'title', title);
        ELSE
          
          SELECT COUNT(TRUONGDA) INTO countt FROM DUAN WHERE TRUONGDA = title;
          IF (countt >0) THEN
            title := 'TruongDuAn';
            DBMS_SESSION.SET_CONTEXT('emp_ctx', 'title', title);
          ELSE
            title := 'NhanVien';
            DBMS_SESSION.SET_CONTEXT('emp_ctx', 'title', title);
          END IF;
        END IF;
      END IF;
   EXCEPTION  
    WHEN NO_DATA_FOUND THEN NULL;
  END;
END;
  /
  show errors
 --tao trigger de moi lan logon 1 user nao do, oracle tu dong chay app context de gan title cho user do 
CREATE OR REPLACE TRIGGER set_title_ctx_trig AFTER LOGON ON DATABASE
 BEGIN
  QTV.set_title_ctx_pkg.set_title;
 END;
 /
 show errors
