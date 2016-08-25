-- connect masterqoala

---
prompt Criando role RL_QOALA para novos usu�rios do sistema
drop role RL_QOALA;
create role RL_QOALA;

GRANT CONNECT TO RL_QOALA;
GRANT CREATE SESSION TO RL_QOALA;
GRANT ALTER SESSION TO RL_QOALA;

--
prompt Criando usuario owner do sistema
drop user qoala cascade;
CREATE USER qoala IDENTIFIED BY "Q41L1@2016"
  DEFAULT TABLESPACE "USERS"
  TEMPORARY TABLESPACE "TEMP";

GRANT ALTER USER TO QOALA;
GRANT CREATE USER TO QOALA;
GRANT DROP USER TO QOALA;

GRANT RL_QOALA to qoala with admin option;

---
prompt Criando usuario de servicos
DROP USER qoala_user;
CREATE USER qoala_user IDENTIFIED BY "Q41L1@2016"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

grant RL_QOALA to qoala_user;
