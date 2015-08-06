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
  <createTable tableName="KRIM_PERM_TMPL_T">
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
  <createIndex tableName="KRIM_PERM_TMPL_T" indexName="KRIM_PERM_TMPL_TI1">
    <column name="NMSPC_CD"/>
    <column name="NM"/>
  </createIndex>

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
      <column name="PERM_TMPL_ID" type="VARCHAR(40)"/>
      <column name="NMSPC_CD" type="VARCHAR(40)">
          <constraints nullable="false"/>
      </column>
      <column name="NM" type="VARCHAR(100)">
          <constraints nullable="false"/>
      </column>
      <column name="DESC_TXT" type="VARCHAR(400)"/>
      <column name="ACTV_IND" type="VARCHAR(1)" defaultValue="Y"/>
  </createTable>
  <createIndex tableName="KRIM_PERM_T" constraintName="KRIM_PERM_TI1">
      <column name="PERM_TMPL_ID" type="VARCHAR(40)"/>
  </createIndex>
  <createIndex tableName="KRIM_PERM_T" constraintName="KRIM_PERM_TI2">
      <column name="PERM_TMPL_ID" type="VARCHAR(40)"/>
      <column name="ACTV_IND" type="VARCHAR(1)"/>
  </createIndex>
  <addUniqueConstraint tableName="KRIM_PERM_T" constraintName="KRIM_PERM_T_TC1" columnNames="NM,NMSPC_CD"/>
  <addForeignKeyConstraint constraintName="KRIM_PERM_TR1" baseTableName="KRIM_PERM_T" baseColumnNames="PERM_TMPL_ID" referencedTableName="KRIM_PERM_TMPL_T" referencedColumnNames="PERM_TMPL_ID"/>

  <createTable tableName="KRIM_PERM_ATTR_DATA_T">
      <column name="ATTR_DATA_ID" type="VARCHAR(40)">
          <constraints primaryKey="true"/>
      </column>
      <column name="OBJ_ID" required="true" size="36" type="VARCHAR">
          <constraints nullable="false" unique="true" uniqueConstraintName="KRIM_PERM_ATTR_DATA_TC0"/>
      </column>
      <column name="VER_NBR" type="DECIMAL(8)" defaultValueNumeric="1">
          <constraints nullable="false"/>
      </column>
      <column name="PERM_ID" type="VARCHAR(40)"/>
      <column name="KIM_TYP_ID" required="true" type="VARCHAR(40)">
          <constraints nullable="false"/>
      </column>
      <column name="KIM_ATTR_DEFN_ID" type="VARCHAR(40)"/>
      <column name="ATTR_VAL" type="VARCHAR(400)"/>
  </createTable>
  <addForeignKey constraintName="KRIM_PERM_ATTR_DATA_TR1" baseTableName="KRIM_PERM_ATTR_DATA_T" baseColumnNames="KIM_TYP_ID" referencedTableName="KRIM_TYP_T" referencedColumnNames="KIM_TYP_ID"/>
  <addForeignKey constraintName="KRIM_PERM_ATTR_DATA_TR2" baseTableName="KRIM_PERM_ATTR_DATA_T" baseColumnNames="KIM_ATTR_DEFN_ID" referencedTableName="KRIM_ATTR_DEFN_T" referencedColumnNames="KIM_ATTR_DEFN_ID"/>
  <addForeignKey constraintName="KRIM_PERM_ATTR_DATA_TR3" baseTableName="KRIM_PERM_ATTR_DATA_T" baseColumnNames="PERM_ID" referencedTableName="KRIM_PERM_T" referencedColumnNames="PERM_ID" onDelete="cascade"/>
  <createIndex tableName="KRIM_PERM_ATTR_DATA_T" indexName="KRIM_PERM_ATTR_DATA_TI1">
      <column name="PERM_ID"/>
  </createIndex>

  <createTable tableName="KRIM_ROLE_PERM_T">
      <column name="ROLE_PERM_ID" primaryKey="true" type="VARCHAR(40)">
          <constraints primaryKey="true"/>
      </column>
      <column name="OBJ_ID" type="VARCHAR(36)">
          <constraints nullable="false" unique="true" uniqueConstraintName="KRIM_ROLE_PERM_TC0"/>
      </column>
      <column name="VER_NBR" type="DECIMAL(8)" defaultValueNumeric="1">
          <constraints nullable="false"/>
      </column>
      <column name="ROLE_ID" type="VARCHAR(40)">
          <constraints nullable="false"/>
      </column>
      <column name="PERM_ID" type="VARCHAR(40)">
          <constraints nullable="false"/>
      </column>
      <column name="ACTV_IND" type="VARCHAR(1)" defaultValue="Y"/>
  </createTable>
  <addForeignKey constraintName="KRIM_ROLE_PERM_TR1" baseTableName="KRIM_ROLE_PERM_T" baseColumnNames="PERM_ID" referencedTableName="KRIM_PERM_T" referencedColumnNames="PERM_ID"/>
  <createIndex tableName="KRIM_ROLE_PERM_T" indexName="KRIM_ROLE_PERM_TI1">
      <column name="PERM_ID"/>
  </createIndex>
  <createIndex tableName="KRIM_ROLE_PERM_T" indexName="KRIM_ROLE_PERM_TI2">
      <column name="PERM_ID"/>
      <column name="ACTV_IND"/>
  </createIndex>
table_creation
