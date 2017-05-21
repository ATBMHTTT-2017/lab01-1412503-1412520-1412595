 ---Trưởng dự án chỉ được phép đọc, ghi thông tin chi tiêu của dự án mình quản lý
GRANT SELECT, INSERT, UPDATE ON CHITIEU TO TruongDuAn;
GRANT SELECT ON DUAN TO TruongDuAn;
 --tạo policy function
 CREATE OR REPLACE FUNCTION auth_chitieu_select( 
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
  IF (title = 'TruongDuAn') THEN
      return_val := 'EXISTS  (SELECT MADA FROM DUAN WHERE MADA = DUAN  AND TRUONGDA = '''  ||  userName || ''' )';
      RETURN return_val;
  END IF;
   RETURN return_val;
 END auth_chitieu_select;
/
 show errors
 
  CREATE OR REPLACE FUNCTION auth_chitieu_insert( 
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
  IF (title = 'TruongDuAn') THEN
      return_val := 'EXISTS  (SELECT MADA FROM DUAN WHERE MADA = DUAN  AND TRUONGDA = '''  ||  userName || ''' )';
      RETURN return_val;
  END IF;
   RETURN return_val;
 END auth_chitieu_insert;
/
 show errors
 --tạo policy
 ---Trưởng dự án chỉ được phép đọc, sửa thông tin chi tiêu của dự án mình quản lý
 BEGIN
  DBMS_RLS.ADD_POLICY (
    object_schema    => 'QTV',
    object_name      => 'CHITIEU',
    policy_name      => 'chitieu_policy',
    function_schema  => 'QTV',
    policy_function  => 'auth_chitieu_select',
    statement_types  => 'select, update'
   );
 ---Trưởng dự án chỉ được phép ghi thông tin chi tiêu của dự án mình quản lý
    DBMS_RLS.add_policy('QTV', 'CHITIEU', 'chitieu_policy1', 
                      'QTV', 'auth_chitieu_insert',
                      'INSERT', TRUE);
 END;
/
