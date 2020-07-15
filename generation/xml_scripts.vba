 Sub script1()
'
' Sub to generate XML scripts
'

'
Sheets("Sheet1").Select
    
    'Variable declaration
    Dim sDir As String
    'Get current directory
    sDir = CurDir
    
    globalDir = sDir + "\generation\"
    MkDir globalDir
            
   'Display output on the screen
    MsgBox "Files will be saved in--  " & globalDir
    
    'To get last visible row number
    Dim lastRow As Long
    lastRow = Range("A" & Rows.Count).End(xlUp).Row
    'MsgBox lastRow
    For currentRow = 2 To lastRow
         Dim id As String
         id = Trim(Cells(currentRow, "A").Value)
         
        pathName = globalDir + "\" + id + "\"
        MkDir pathName
        
         file1 = pathName + "DefaultList.xml"
         file2 = pathName + "DefaultEndpointList.xml"
         
         Set objStream = CreateObject("ADODB.Stream")
         objStream.Charset = "iso-8859-1"
         
         objStream.Open
         objStream.WriteText ("<CusList>" & vbLf)
         objStream.WriteText ("  <Cus>" & vbLf)
         objStream.WriteText ("      <Customer>Default</Customer>" & vbLf)
         objStream.WriteText ("      <CustomerId>" + id + "<Customer/Id>" & vbLf)
         objStream.WriteText ("      <NttyCustomerCd>ACTIVE</NttyCustomerCd>" & vbLf)
         objStream.WriteText ("      <FctvFr>2020-04-12T00:00:00</FctvFr>" & vbLf)
         objStream.WriteText ("      <PtyCd>" + id + "</PtyCd>" & vbLf)
         objStream.WriteText ("      <PtyNm>" + id + "</PtyNm>" & vbLf)
         objStream.WriteText ("      <PtyDispNm>" + id + "</PtyDispNm>" & vbLf)
         objStream.WriteText ("      <CustomerTp>HEARD</CustomerTp>" & vbLf)
         objStream.WriteText ("      <PCustomerIdr>CRITICAL</CustomerIdr>" & vbLf)
         objStream.WriteText ("      <CustomerCalCd>Default</CustomerCalCd>" & vbLf)
         objStream.WriteText ("   </Cus>" & vbLf)
         objStream.WriteText ("</CusList>" & vbLf)
         objStream.SaveToFile file1, 2
         objStream.Close
         
         'For second list
         objStream.Open
         objStream.WriteText ("<CustomerEndpointList>" & vbLf)
         
         Dim countryCode As String
         countryCode = Trim(Cells(currentRow, "C").Value)
         
         Dim stateCode As String
         stateCode = Trim(Cells(currentRow, "D").Value)
         
         Dim sectionCode As String
         sectionCode = Trim(Cells(currentRow, "F").Value)
         
         Dim courses As String
         courses = Trim(Cells(currentRow, "E").Value)
         
         Dim coursesArray
         coursesArray = Split(courses, ",")
         
         For i = LBound(coursesArray) To UBound(coursesArray)
         'MsgBox coursesArray(i)
         
         objStream.WriteText ("  <EndCustomerpoint>" & vbLf)
         objStream.WriteText ("      <Customer>Default</Customer>" & vbLf)
         objStream.WriteText ("      <CustomerId>" + countryCode + "_" + stateCode + "_" + coursesArray(i) + "_" + sectionCode + "</CustomerId>" & vbLf)
         objStream.WriteText ("     <CustomerNttyStsCd>ACTIVE</CustomerNttyStsCd>" & vbLf)
         objStream.WriteText ("     <CustomerFctvFr>2017-07-23T11:24:27.548</CustomerFctvFr>" & vbLf)
         objStream.WriteText ("     <CustomerNdPtCd>VBA_" + countryCode + "_" + stateCode + "_" + coursesArray(i) + "_" + sectionCode + "_Flow</CustomerNdPtCd>" & vbLf)
         objStream.WriteText ("     <CustomerNdPtNm>" + coursesArray(i) + " " + sectionCode + "</CustomerNdPtNm>" & vbLf)
         objStream.WriteText ("     <CustomerIsFldDataPrst>true</CustomerIsFldDataPrst>" & vbLf)
         objStream.WriteText ("     </EndCustomerpoint>" & vbLf)
         
         Next
         
         objStream.WriteText ("     </CustomerEndpointList>" & vbLf)
         objStream.SaveToFile file2, 2
         objStream.Close

Next currentRow

      

End Sub



