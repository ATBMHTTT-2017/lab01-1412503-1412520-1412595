-- VPD Trưởng phòng chỉ được phép đọc thông tin chi tiêu của dự án
GRANT SELECT ON CHITIEU TO TruongPhong;
-- Trưởng phòng chỉ được phép đọc thông tin chi tiêu của dự án trong phòng ban mình quản lý.
CREATE OR REPLACE FUNCTION auth_chitieu_select_tp( 
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
 )
 RETURN VARCHAR2
 IS
  return_val VARCHAR2 (500);
  userName VARCHAR2(6);
  title varchar2(20);
  countt integer;
 BEGIN
  SELECT SYS_CONTEXT('emp_ctx', 'title') INTO title FROM DUAL;
  SELECT SYS_CONTEXT('userenv', 'SESSION_USER') INTO userName FROM DUAL;
  IF (title = 'TruongPhong') THEN
      return_val := 'EXISTS  (SELECT da.MADA 
                              FROM DUAN da, PHONGBAN pb
                              WHERE '''  ||  userName || ''' = pb.truongPhong AND pd.maPhong = da.phongChuTri)';
      RETURN return_val;
  END IF;
   RETURN return_val;
 END auth_chitieu_select_tp;
/
 show errors
 
-- Với những dự án không thuộc phòng ban của mình, các trưởng phòng được phép xem thông tin chi tiêu nhưng không được phép xem số tiền cụ thể (VPD) 
 CREATE OR REPLACE FUNCTION auth_chitieu_select_nottp( 
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
 )
 RETURN VARCHAR2
 IS
  return_val VARCHAR2 (500);
  userName VARCHAR2(6);
  title varchar2(20);
  countt integer;
 BEGIN
  SELECT SYS_CONTEXT('emp_ctx', 'title') INTO title FROM DUAL;
  SELECT SYS_CONTEXT('userenv', 'SESSION_USER') INTO userName FROM DUAL;
  IF (title = 'TruongPhong') THEN
      return_val := 'EXISTS  (SELECT da.MADA 
                              FROM DUAN da, PHONGBAN pb
                              WHERE '''  ||  userName || ''' = pb.truongPhong AND pd.maPhong != da.phongChuTri)';
      RETURN return_val;
  END IF;
   RETURN return_val;
 END auth_chitieu_select_nottp;
/
show errors
 
 BEGIN
   -- Trưởng phòng xem chi tiêu dự án của phòng khác
  DBMS_RLS.ADD_POLICY (
    object_schema     => 'QTV',
    object_name       => 'CHITIEU',
    policy_name       => 'nottp_chitieu_policy',
    function_schema   => 'QTV',
    policy_function   => 'auth_chitieu_select_nottp',
    statement_types   => 'select',
    sec_relevant_cols => 'soTien',
    sec_relevant_cols_opt => dbms_rls.ALL_ROWS
   );
   -- Trưởng phòng xem chi tiêu dự án của phòng mình quản lý
  DBMS_RLS.ADD_POLICY ('QTV', 'CHITIEU', 'tp_chitieu_policy', 'QTV', 'auth_chitieu_select_tp', 'select');
 END;
/
show errors
