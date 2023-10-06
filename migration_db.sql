-- Before, import mariadb as postgresql with pgloader

----------------------
---- USER CLEANUP ----
----------------------
DELETE FROM intra_user iu WHERE NOT EXISTS (SELECT FROM intra_pizzauserorder WHERE user_id=iu.id) AND NOT EXISTS (SELECT FROM intra_tournamentmanager WHERE user_id=iu.id) AND enabled=FALSE;

-- People still click on random links reaching their emails it seems
DELETE FROM intra_user WHERE username LIKE '%http%';
DELETE FROM intra_user WHERE (id >= 45209 AND id <= 46215) OR (id >= 46487 AND id <= 62128);




----------------------
---- TABLES TO DO ----
----------------------
                        List of relations
  Schema   |               Name                | Type  |  Owner
-----------+-----------------------------------+-------+----------
 insalanfr | intra_archivesedition             | table | postgres
 insalanfr | intra_archivespicturealbum        | table | postgres
 insalanfr | intra_archivesstream              | table | postgres
 insalanfr | intra_e_ticket                    | table | postgres
 insalanfr | intra_ext_log_entries             | table | postgres
 insalanfr | intra_insalanglobalvars           | table | postgres
 insalanfr | intra_insalanstaff                | table | postgres
 insalanfr | intra_legal_document              | table | postgres
 insalanfr | intra_news                        | table | postgres
 insalanfr | intra_news_picture                | table | postgres
 insalanfr | intra_newsslider                  | table | postgres
 insalanfr | intra_participant                 | table | postgres
 insalanfr | intra_payum_payment_details       | table | postgres
 insalanfr | intra_pizza                       | table | postgres
 insalanfr | intra_pizzaorder                  | table | postgres
 insalanfr | intra_pizzauserorder              | table | postgres
 insalanfr | intra_player                      | table | postgres
 insalanfr | intra_player_tournamentteam       | table | postgres
-- insalanfr | intra_registrable                 | table | postgres
 insalanfr | intra_stream                      | table | postgres
-- insalanfr | intra_tournament                  | table | postgres
 insalanfr | intra_tournamentbundle            | table | postgres
 insalanfr | intra_tournamentbundle_tournament | table | postgres
 insalanfr | intra_tournamentgroup             | table | postgres
 insalanfr | intra_tournamentgroup_participant | table | postgres
 insalanfr | intra_tournamentgroupstage        | table | postgres
 insalanfr | intra_tournamentknockout          | table | postgres
 insalanfr | intra_tournamentknockoutmatch     | table | postgres
 insalanfr | intra_tournamentmanager           | table | postgres
 insalanfr | intra_tournamentmatch             | table | postgres
 insalanfr | intra_tournamentround             | table | postgres
 insalanfr | intra_tournamentscore             | table | postgres
 insalanfr | intra_tournamentteam              | table | postgres
--  insalanfr | intra_user                        | table | postgres
 insalanfr | intra_userdiscount                | table | postgres
 insalanfr | intra_usermerchantorder           | table | postgres
 insalanfr | intra_usermerchantorder_player    | table | postgres
 insalanfr | intra_userpaymenttoken            | table | postgres
 insalanfr | lexik_maintenance                 | table | postgres
 insalanfr | migration_versions                | table | postgres
 insalanfr | tournamentroyalmatch_participant  | table | postgres


 Schema |            Name            | Type  |  Owner
--------+----------------------------+-------+---------
-- public | auth_group                 | table | insalan
-- public | auth_group_permissions     | table | insalan
 public | auth_permission            | table | insalan
 public | django_admin_log           | table | insalan
 public | django_content_type        | table | insalan
 public | django_migrations          | table | insalan
 public | django_session             | table | insalan
 public | partner_partner            | table | insalan
 public | tickets_ticket             | table | insalan
 public | tournament_event           | table | insalan
 public | tournament_game            | table | insalan
 public | tournament_manager         | table | insalan
 public | tournament_player          | table | insalan
 public | tournament_team            | table | insalan
 public | tournament_tournament      | table | insalan
-- public | user_user                  | table | insalan
-- public | user_user_groups           | table | insalan
-- public | user_user_user_permissions | table | insalan

--
-- <field> (<length>, max=<max length found in current DB>) -> <field> (<length>)
--
----------------------
---- USER MAPPING ----
----------------------
--
-- intra_user -> user_user
--
-- id -> id
-- username (180, max=29) -> username (150)
-- salt -> NO USER SALT ??
-- "TRUE" -> old_user (boolean, defaults to false)
-- email (180) -> email (255)
-- enabled -> email_active
-- birthdate -> birtd
-- firstname (255, max=15) -> first_name (50)
-- lastname (255, max=23) -> last_name (50)
-- last_login -> last_login
-- 01-01-2000 -> date_joined ??
-- steamid ??

Referenced by:
    TABLE "intra_pizzauserorder" CONSTRAINT "fk_b81400c5a76ed395" FOREIGN KEY (user_id) REFERENCES intra_user(id) ON UPDATE RESTRICT ON DELETE RESTRICT
    TABLE "intra_usermerchantorder" CONSTRAINT "fk_c0c5840a6796d554" FOREIGN KEY (merchant_id) REFERENCES intra_user(id) ON UPDATE RESTRICT ON DELETE RESTRICT
    TABLE "intra_payum_payment_details" CONSTRAINT "fk_eafe1b0a76ed395" FOREIGN KEY (user_id) REFERENCES intra_user(id) ON UPDATE RESTRICT ON DELETE RESTRICT





----------------------
----- tournament -----
----------------------
--
-- 
--
-- tournament.id -> id
-- tournament.participanttype -> (TODO dans game)
-- tournament.teamminplayer -> (TODO dans game)
-- tournament.teammaxplayer -> (TODO dans tournament)
-- tournament.registrationopen -> (TODO dans tournament)
-- tournament.registrationlimit -> (TODO dans tournament)
-- (TODO login types)
-- (TODO price)
-- (TODO locked)
-- tournament.maxmanager -> (TODO dans tournament)
-- registrable.name (50, max=45) -> name (40) !!
-- registrable.description (255, max=151) -> description (128) !!
-- registrable.logopath (255, max=45) -> logo (100)
-- tournament.rules -> rules
-- tournament.tournamentopen -> year, month (have fun)

Foreign-key constraints:
    "fk_c79ebaf1bf396750" FOREIGN KEY (id) REFERENCES intra_registrable(id) ON UPDATE RESTRICT ON DELETE CASCADE
Referenced by:
    TABLE "intra_tournamentbundle_tournament" CONSTRAINT "fk_2fd0e1b633d1a3e7" FOREIGN KEY (tournament_id) REFERENCES intra_tournament(id) ON UPDATE RESTRICT ON DELETE CASCADE
    TABLE "intra_tournamentknockout" CONSTRAINT "fk_372bf28833d1a3e7" FOREIGN KEY (tournament_id) REFERENCES intra_tournament(id) ON UPDATE RESTRICT ON DELETE CASCADE
    TABLE "intra_stream" CONSTRAINT "fk_6220c08b33d1a3e7" FOREIGN KEY (tournament_id) REFERENCES intra_tournament(id) ON UPDATE RESTRICT ON DELETE RESTRICT
    TABLE "intra_e_ticket" CONSTRAINT "fk_7e1d549133d1a3e7" FOREIGN KEY (tournament_id) REFERENCES intra_tournament(id) ON UPDATE RESTRICT ON DELETE RESTRICT
    TABLE "intra_tournamentmanager" CONSTRAINT "fk_94ddea2033d1a3e7" FOREIGN KEY (tournament_id) REFERENCES intra_tournament(id) ON UPDATE RESTRICT ON DELETE RESTRICT
    TABLE "intra_tournamentgroupstage" CONSTRAINT "fk_d03952e33d1a3e7" FOREIGN KEY (tournament_id) REFERENCES intra_tournament(id) ON UPDATE RESTRICT ON DELETE CASCADE
    TABLE "intra_participant" CONSTRAINT "fk_e25002e933d1a3e7" FOREIGN KEY (tournament_id) REFERENCES intra_tournament(id) ON UPDATE RESTRICT ON DELETE CASCADE

    TABLE "intra_tournamentbundle" CONSTRAINT "fk_37b24c6abf396750" FOREIGN KEY (id) REFERENCES intra_registrable(id)
ON UPDATE RESTRICT ON DELETE CASCADE
    TABLE "intra_userdiscount" CONSTRAINT "fk_685d662141b618a8" FOREIGN KEY (registrable_id) REFERENCES intra_registra
ble(id) ON UPDATE RESTRICT ON DELETE RESTRICT
    TABLE "intra_player" CONSTRAINT "fk_ad004f2f113f701" FOREIGN KEY (pendingregistrable_id) REFERENCES intra_registra
ble(id) ON UPDATE RESTRICT ON DELETE RESTRICT
    TABLE "intra_tournament" CONSTRAINT "fk_c79ebaf1bf396750" FOREIGN KEY (id) REFERENCES intra_registrable(id) ON UPD
ATE RESTRICT ON DELETE CASCADE

