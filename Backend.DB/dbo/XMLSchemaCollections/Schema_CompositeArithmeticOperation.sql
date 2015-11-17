﻿CREATE XML SCHEMA COLLECTION [dbo].[Schema_CompositeArithmeticOperation]
    AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified">
  <xsd:element name="Request">
    <xsd:complexType>
      <xsd:complexContent>
        <xsd:extension base="Request_BaseType">
          <xsd:sequence>
            <xsd:element name="OperationData" type="OperationData" />
          </xsd:sequence>
        </xsd:extension>
      </xsd:complexContent>
    </xsd:complexType>
  </xsd:element>
  <xsd:attributeGroup name="BaseRequest_AG">
    <xsd:attribute name="BranchId" type="xsd:unsignedInt" />
    <xsd:attribute name="UserId" type="xsd:unsignedInt" use="required" />
    <xsd:attribute name="AppDate" type="datetimeSQL" use="required" />
    <xsd:attribute name="StatusS" type="xsd:unsignedInt" />
    <xsd:attribute name="StatusP" type="xsd:unsignedInt" />
    <xsd:attribute name="StatusW" type="xsd:unsignedInt" />
    <xsd:attribute name="RequestType" type="ProcedureEnum_Type" use="required" />
  </xsd:attributeGroup>
  <xsd:complexType name="CompositeOperation">
    <xsd:complexContent>
      <xsd:restriction base="xsd:anyType">
        <xsd:choice minOccurs="2" maxOccurs="2">
          <xsd:sequence>
            <xsd:element name="Function" type="Function" />
          </xsd:sequence>
          <xsd:sequence>
            <xsd:element name="SimpleValue" type="SimpleValue" />
          </xsd:sequence>
          <xsd:sequence>
            <xsd:element name="CompositeOperation" type="CompositeOperation" />
          </xsd:sequence>
        </xsd:choice>
        <xsd:attribute name="Operation" type="OperationEnum" use="required" />
        <xsd:attribute name="Lp" type="LpRange" use="required" />
        <xsd:attribute name="Level" type="xsd:unsignedInt" />
      </xsd:restriction>
    </xsd:complexContent>
  </xsd:complexType>
  <xsd:complexType name="Function">
    <xsd:complexContent>
      <xsd:restriction base="xsd:anyType">
        <xsd:sequence>
          <xsd:element name="FunctionParameter" type="FunctionParameter" minOccurs="0" maxOccurs="unbounded" />
        </xsd:sequence>
        <xsd:attribute name="Lp" type="LpRange" use="required" />
        <xsd:attribute name="Name" type="ValueString" use="required" />
      </xsd:restriction>
    </xsd:complexContent>
  </xsd:complexType>
  <xsd:complexType name="FunctionParameter">
    <xsd:complexContent>
      <xsd:restriction base="xsd:anyType">
        <xsd:choice>
          <xsd:sequence>
            <xsd:element name="Scalar" type="Scalar" />
          </xsd:sequence>
          <xsd:sequence>
            <xsd:element name="Relation" type="TargetRelation" />
          </xsd:sequence>
          <xsd:sequence>
            <xsd:element name="Unit" type="TargetUnit" />
          </xsd:sequence>
        </xsd:choice>
        <xsd:attribute name="Name" type="ValueString" use="required" />
      </xsd:restriction>
    </xsd:complexContent>
  </xsd:complexType>
  <xsd:complexType name="OperationData">
    <xsd:complexContent>
      <xsd:restriction base="xsd:anyType">
        <xsd:sequence>
          <xsd:choice minOccurs="0">
            <xsd:sequence>
              <xsd:element name="Relation" type="TargetRelation" />
            </xsd:sequence>
            <xsd:sequence>
              <xsd:element name="Unit" type="TargetUnit" />
            </xsd:sequence>
          </xsd:choice>
          <xsd:element name="CompositeOperation" type="CompositeOperation" />
        </xsd:sequence>
        <xsd:attribute name="UnitTypeOperationId" type="xsd:int" use="required" />
        <xsd:attribute name="RelationOperationAttributeId" type="xsd:int" use="required" />
        <xsd:attribute name="ValueAttributeTypeId" type="xsd:int" use="required" />
        <xsd:attribute name="UnitTypeValueId" type="xsd:int" use="required" />
      </xsd:restriction>
    </xsd:complexContent>
  </xsd:complexType>
  <xsd:complexType name="Request_BaseType">
    <xsd:complexContent>
      <xsd:restriction base="xsd:anyType">
        <xsd:sequence />
        <xsd:attributeGroup ref="BaseRequest_AG" />
      </xsd:restriction>
    </xsd:complexContent>
  </xsd:complexType>
  <xsd:complexType name="Scalar">
    <xsd:complexContent>
      <xsd:restriction base="xsd:anyType">
        <xsd:sequence />
        <xsd:attribute name="Value" type="ScalarValue" use="required" />
      </xsd:restriction>
    </xsd:complexContent>
  </xsd:complexType>
  <xsd:complexType name="SimpleValue">
    <xsd:complexContent>
      <xsd:restriction base="xsd:anyType">
        <xsd:choice>
          <xsd:sequence>
            <xsd:element name="Scalar" type="Scalar" />
          </xsd:sequence>
          <xsd:sequence>
            <xsd:element name="Relation" type="TargetRelation" />
          </xsd:sequence>
          <xsd:sequence>
            <xsd:element name="Unit" type="TargetUnit" />
          </xsd:sequence>
        </xsd:choice>
        <xsd:attribute name="Lp" type="LpRange" use="required" />
      </xsd:restriction>
    </xsd:complexContent>
  </xsd:complexType>
  <xsd:complexType name="TargetRelation">
    <xsd:complexContent>
      <xsd:restriction base="xsd:anyType">
        <xsd:sequence />
        <xsd:attribute name="Id" type="xsd:unsignedInt" use="required" />
        <xsd:attribute name="AttributeTypeId" type="xsd:unsignedInt" use="required" />
      </xsd:restriction>
    </xsd:complexContent>
  </xsd:complexType>
  <xsd:complexType name="TargetUnit">
    <xsd:complexContent>
      <xsd:restriction base="xsd:anyType">
        <xsd:sequence />
        <xsd:attribute name="Id" type="xsd:unsignedInt" use="required" />
        <xsd:attribute name="TypeId" type="xsd:unsignedInt" use="required" />
        <xsd:attribute name="AttributeTypeId" type="xsd:unsignedInt" use="required" />
      </xsd:restriction>
    </xsd:complexContent>
  </xsd:complexType>
  <xsd:simpleType name="LpRange">
    <xsd:restriction base="xsd:unsignedInt">
      <xsd:minInclusive value="1" />
      <xsd:maxInclusive value="2" />
    </xsd:restriction>
  </xsd:simpleType>
  <xsd:simpleType name="OperationEnum">
    <xsd:restriction base="xsd:string">
      <xsd:enumeration value="Mul" />
      <xsd:enumeration value="Div" />
      <xsd:enumeration value="Sum" />
      <xsd:enumeration value="Sub" />
    </xsd:restriction>
  </xsd:simpleType>
  <xsd:simpleType name="ProcedureEnum_Type">
    <xsd:restriction base="xsd:string">
      <xsd:enumeration value="Units_GetOfType" />
      <xsd:enumeration value="Units_Get" />
      <xsd:enumeration value="Units_Delete" />
      <xsd:enumeration value="Units_Save" />
      <xsd:enumeration value="Units_GetRelationsCount" />
      <xsd:enumeration value="Units_GetHistory" />
      <xsd:enumeration value="Relations_GetByIds" />
      <xsd:enumeration value="Relations_GetFurther" />
      <xsd:enumeration value="Relations_Get" />
      <xsd:enumeration value="Relations_Delete" />
      <xsd:enumeration value="Relations_Save" />
      <xsd:enumeration value="Relations_GetHistory" />
      <xsd:enumeration value="Branches_Get" />
      <xsd:enumeration value="Branches_Delete" />
      <xsd:enumeration value="Branches_Save" />
      <xsd:enumeration value="Branches_GetHistory" />
      <xsd:enumeration value="UnitTypes_Get" />
      <xsd:enumeration value="UnitTypes_GetByIds" />
      <xsd:enumeration value="UnitTypes_Delete" />
      <xsd:enumeration value="UnitTypes_Save" />
      <xsd:enumeration value="UnitTypes_GetHistory" />
      <xsd:enumeration value="StructureTypes_Get" />
      <xsd:enumeration value="StructureTypes_GetByIds" />
      <xsd:enumeration value="StructureTypes_Delete" />
      <xsd:enumeration value="StructureTypes_Save" />
      <xsd:enumeration value="StructureTypes_GetHistory" />
      <xsd:enumeration value="UnitTypes_Branches_Get" />
      <xsd:enumeration value="AttributeTypes_Get" />
      <xsd:enumeration value="AttributeTypes_Delete" />
      <xsd:enumeration value="AttributeTypes_Save" />
      <xsd:enumeration value="AttributeTypes_GetHistory" />
      <xsd:enumeration value="AttributeTypes_IsUsedByUnitType" />
      <xsd:enumeration value="DataTypes_Get" />
      <xsd:enumeration value="DataTypes_Delete" />
      <xsd:enumeration value="DataTypes_Save" />
      <xsd:enumeration value="DataTypes_GetHistory" />
      <xsd:enumeration value="Dictionary_Get" />
      <xsd:enumeration value="Dictionary_GetByIds" />
      <xsd:enumeration value="Dictionary_GetValuesByAttributeId" />
      <xsd:enumeration value="Dictionary_Delete" />
      <xsd:enumeration value="Dictionary_Save" />
      <xsd:enumeration value="Dictionary_GetHistory" />
      <xsd:enumeration value="UnitsOfMeasure_Get" />
      <xsd:enumeration value="UnitsOfMeasure_GetHistory" />
      <xsd:enumeration value="UnitsOfMeasure_Delete" />
      <xsd:enumeration value="UnitsOfMeasure_Save" />
      <xsd:enumeration value="UnitsOfMeasure_GetHistory" />
      <xsd:enumeration value="RelationTypes_Get" />
      <xsd:enumeration value="RelationTypes_GetByIds" />
      <xsd:enumeration value="RelationTypes_Delete" />
      <xsd:enumeration value="RelationTypes_Save" />
      <xsd:enumeration value="RelationTypes_GetHistory" />
      <xsd:enumeration value="RelationBaseTypes_Get" />
      <xsd:enumeration value="RelationBaseTypes_GetHistory" />
      <xsd:enumeration value="Structures_GetOfType" />
      <xsd:enumeration value="Structures_GetByIds" />
      <xsd:enumeration value="Structures_Delete" />
      <xsd:enumeration value="Structures_Save" />
      <xsd:enumeration value="Structures_GetHistory" />
      <xsd:enumeration value="Structures_DeleteElements" />
      <xsd:enumeration value="Attribute_GetHistory" />
      <xsd:enumeration value="Users_Get" />
      <xsd:enumeration value="User_IsAdminGuaranteed" />
      <xsd:enumeration value="User_IsLoginUnique" />
      <xsd:enumeration value="Users_Delete" />
      <xsd:enumeration value="Users_Save" />
      <xsd:enumeration value="Users_GetByLogin" />
      <xsd:enumeration value="Users_AreCredentialsValid" />
      <xsd:enumeration value="UserGroups_Get" />
      <xsd:enumeration value="UserGroups_Delete" />
      <xsd:enumeration value="UserGroups_Save" />
      <xsd:enumeration value="Roles_Get" />
      <xsd:enumeration value="Roles_Delete" />
      <xsd:enumeration value="Roles_Save" />
      <xsd:enumeration value="Roles_DeleteAssignedOperations" />
      <xsd:enumeration value="Operations_Get" />
      <xsd:enumeration value="Attributes_GetHistory" />
      <xsd:enumeration value="AttributeTypes_GetAvailable" />
      <xsd:enumeration value="Dictionary_DeleteEntries" />
      <xsd:enumeration value="AttributeTypes_GetByIds" />
      <xsd:enumeration value="AttributeTypes_DeleteAssignedBranches" />
      <xsd:enumeration value="RelationTypes_DeleteAssignedAttributeTypes" />
      <xsd:enumeration value="UnitTypes_DeleteAssignedAttributeTypes" />
      <xsd:enumeration value="Structures_GetByUnit" />
      <xsd:enumeration value="UserGroups_DeleteAssignedUsers" />
      <xsd:enumeration value="UserGroups_DeleteAssignedRoles" />
      <xsd:enumeration value="UnitsOfMeasure_DeleteAssignedConversions" />
      <xsd:enumeration value="StructureTypes_DeleteElements" />
      <xsd:enumeration value="AttributeTypes_IsUsed" />
      <xsd:enumeration value="Structures_GetByUnitType" />
      <xsd:enumeration value="UserSettings_Save" />
      <xsd:enumeration value="Relations_GetOfType" />
      <xsd:enumeration value="RelationBaseTypes_Save" />
      <xsd:enumeration value="RelationBaseTypes_Delete" />
      <xsd:enumeration value="Database_GetStatistics" />
      <xsd:enumeration value="Database_Upgrade" />
      <xsd:enumeration value="Database_GetBackups" />
      <xsd:enumeration value="Database_GetVersion" />
      <xsd:enumeration value="Database_CreateBackup" />
      <xsd:enumeration value="Units_SaveAlternativeHistoryAttribute" />
      <xsd:enumeration value="Units_SetMainHistFlowForAttribute" />
      <xsd:enumeration value="SimpleOperation_Sum" />
      <xsd:enumeration value="SimpleOperation_Sub" />
      <xsd:enumeration value="SimpleOperation_Mul" />
      <xsd:enumeration value="SimpleOperation_Div" />
      <xsd:enumeration value="CompositeArithmeticOperation" />
    </xsd:restriction>
  </xsd:simpleType>
  <xsd:simpleType name="ScalarValue">
    <xsd:restriction base="xsd:string">
      <xsd:minLength value="1" />
      <xsd:pattern value="[-]?([0-9])+(.([0-9])+)?" />
    </xsd:restriction>
  </xsd:simpleType>
  <xsd:simpleType name="ValueString">
    <xsd:restriction base="xsd:string">
      <xsd:minLength value="1" />
      <xsd:pattern value=".*[^\s].*" />
    </xsd:restriction>
  </xsd:simpleType>
  <xsd:simpleType name="datetimeSQL">
    <xsd:restriction base="xsd:string">
      <xsd:pattern value="((000[1-9])|(00[1-9][0-9])|(0[1-9][0-9]{2})|([1-9][0-9]{3}))-((0[1-9])|(1[012]))-((0[1-9])|([12][0-9])|(3[01]))T(([01][0-9])|(2[0-3]))(:[0-5][0-9]){2}(\.[0-9]{1,3})?(Z?)" />
    </xsd:restriction>
  </xsd:simpleType>
</xsd:schema>';

