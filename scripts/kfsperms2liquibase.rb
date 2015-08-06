####################################################################################
# Copyright 2005-2015 The Kuali Foundation
#
# Licensed under the Educational Community License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.opensource.org/licenses/ecl2.php
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
####################################################################################

require 'csv'

TABLE_CREATION = <<-table_creation
  <createTable name="KRIM_PERM_TMPL_T">
      <column name="PERM_TMPL_ID" type="VARCHAR(40)">
          <constraints primaryKey="true"/>
      </column>
      <column name="OBJ_ID" type="VARCHAR(36)">
          <constraints nullable="false" unique="true" uniqueConstraintName="KRIM_PERM_TMPL_TC0"/>
      </column>
      <column name="VER_NBR" type="DECIMAL(8)" defaultValueNumeric="1" nullable="false">
          <constraints nullable="false"/>
      </column>
      <column name="NMSPC_CD" nullable="false" type="VARCHAR(40)">
          <constraints nullable="false"/>
      </column>
      <column name="NM" type="VARCHAR(100)">
          <constraints nullable="false"/>
      </column>
      <column name="DESC_TXT" type="VARCHAR(400)"/>
      <column name="KIM_TYP_ID" nullable="false" type="VARCHAR(40)">
          <constraints nullable="false"/>
      </column>
      <column name="ACTV_IND" type="VARCHAR(1)" defaultValue="Y"/>
  </createTable>
  <addUniqueConstraint tableName="KRIM_PERM_TMPL_T" constraintName="KRIM_PERM_TMPL_TC1" columnNames="NM,NMSPC_CD"/>
  <addForeignKeyConstraint constraintName="KRIM_PERM_TMPL_TR1" baseTableName="KRIM_PERM_TMPL_T" baseColumnNames="KIM_TYP_ID" referencedTableName="KRIM_TYP_T" referencedColumnNames="KIM_TYP_ID"/>

  <createTable name="KRIM_PERM_T">
      <column name="PERM_ID" type="VARCHAR(40)">
          <constraints primaryKey="true"/>
      </column>
      <column name="OBJ_ID" type="VARCHAR(36)">
          <constraints nullable="false" unique="true" uniqueConstraintName="KRIM_PERM_TC0"/>
      </column>
      <column name="VER_NBR" type="DECIMAL(8)" defaultValueNumeric="1">
          <constraints nullable="false"/>
      </column>
      <column name="PERM_TMPL_ID" type="VARCHAR(40)">
          <constraints unique="true" uniqueConstraintName="KRIM_PERM_TI1"/>
      </column>
      <column name="NMSPC_CD" type="VARCHAR(40)">
          <constraints nullable="false"/>
      </column>
      <column name="NM" type="VARCHAR(100)">
          <constraints nullable="false"/>
      </column>
      <column name="DESC_TXT" type="VARCHAR(400)"/>
      <column name="ACTV_IND" type="VARCHAR(1)" defaultValue="Y"/>
  </createTable>
  <addUniqueConstraint tableName="KRIM_PERM_T" constraintName="KRIM_PERM_TI2" columnNames="PERM_TMPL_ID,ACTV_IND"/>
  <addUniqueConstraint tableName="KRIM_PERM_T" constraintName="KRIM_PERM_T_TC1" columnNames="NM,NMSPC_CD"/>
  <addForeignKeyConstraint constraintName="KRIM_PERM_TR1" baseTableName="KRIM_PERM_T" baseColumnNames="PERM_TMPL_ID" referencedTableName="KRIM_PERM_TMPL_T" referencedColumnNames="PERM_TMPL_ID"/>
table_creation
