--Tất cả nhân viên bình thường (trừ trưởng phòng, trưởng chi nhánh và các trưởng dự án) 
 ---Nhân viên chỉ được xem lương của mình
 CREATE OR REPLACE FUNCTION auth_nhanvien_select( 
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
 )
 RETURN VARCHAR2
 IS
  return_val VARCHAR2 (500);
  userName VARCHAR2(6);
  title varchar2(20);
 BEGIN
  SELECT SYS_CONTEXT('emp_ctx', 'title') INTO title FROM DUAL;
  SELECT SYS_CONTEXT('userenv', 'SESSION_USER') INTO userName FROM DUAL;
  IF (title = 'NhanVien') THEN
      return_val := 'MANV = '''  || userName || ''' ';
      RETURN return_val;
  END IF;
    return_val := '';
    RETURN return_val;
 END auth_nhanvien_select;
/
 show errors
 
 --Tất cả nhân viên bình thường (trừ trưởng phòng, trưởng chi nhánh và các trưởng dự án) 
 --chỉ được phép xem thông tin nhân viên trong phòng của mình,
 CREATE OR REPLACE FUNCTION auth_nhanvienPhong_select( 
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
 )
 RETURN VARCHAR2
 IS
  return_val VARCHAR2 (500);
  userName VARCHAR2(6);
  title varchar2(20);
 BEGIN
  SELECT SYS_CONTEXT('emp_ctx', 'title') INTO title FROM DUAL;
  SELECT SYS_CONTEXT('userenv', 'SESSION_USER') INTO userName FROM DUAL;
  IF (title = 'NhanVien') THEN
      return_val := 'EXISTS  (SELECT T2.MAPHONG FROM NHANVIEN T1, NHANVIEN T2  WHERE T1.MAPHONG = T2.MAPHONG  AND T1.MANV = '''  ||  userName || ''' )';
      RETURN return_val;
  END IF;
    return_val := '';
    RETURN return_val;
 END auth_nhanvienPhong_select;
/
 show errors
 
  BEGIN
  --LƯƠNG
    DBMS_RLS.ADD_POLICY (
    object_schema    => 'QTV',
    object_name      => 'NHANVIEN',
    policy_name      => 'NV_Policy',
    function_schema  => 'QTV',
    policy_function  => 'auth_nhanvien_select',
    statement_types  => 'select',
    sec_relevant_cols => 'LUONG',
    sec_relevant_cols_opt => dbms_rls.ALL_ROWS
   );
   --PHÒNG
    DBMS_RLS.ADD_POLICY ('QTV', 'NHANVIEN', 'NVPhong_Policy', 'QTV', 'auth_nhanvienPhong_select', 'select'
   );
  END;
/
 show errors
 
