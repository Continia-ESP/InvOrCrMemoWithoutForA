codeunit 60120 "CDC Purchase Subs."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDC Purch. - Full Capture", 'OnBeforeCalculateDueDate', '', true, true)]
    local procedure OnBeforeCalculationDueDate(var Document: Record "CDC Document")
    var
        Field1: Record "CDC Template Field";
        Field2: Record "CDC Template Field";
        DocumentValue: Record "CDC Document Value";
        CaptureMgt: Codeunit "CDC Capture Management";
        PurchDocMgt: Codeunit "CDC Purch. Doc. - Management";
        DocType: Integer;
        TextInvoice: TextConst ENU = 'I', ESP = 'F';
        TextCrMemo: TextConst ENU = 'Cr', ESP = 'A';
    begin
        Field1.GET(Document."Template No.", Field1.Type::Header, 'AMOUNTINCLVAT');
        IF CaptureMgt.GetDecimal(Document, Field1.Type, Field1.Code, 0) >= 0 THEN BEGIN
            IF Field2.GET(Document."Template No.", Field2.Type::Header, 'DOCTYPE') THEN
                CaptureMgt.UpdateFieldValue(Document."No.", 0, 0, Field2, TextInvoice, TRUE, true)
        END ELSE BEGIN
            IF Field2.GET(Document."Template No.", Field2.Type::Header, 'DOCTYPE') THEN begin
                CaptureMgt.UpdateFieldValue(Document."No.", 0, 0, Field2, TextCrMemo, TRUE, true);

                if DocumentValue.GET(Document."No.", true, Field1.Code, 0) then
                    CaptureMgt.UpdateFieldValue(Document."No.", 0, 0, Field1, DelChr(DocumentValue."Value (Text)", '<', '-'), TRUE, true);

                Field1.Get(Document."Template No.", Field1.Type::Header, 'AMOUNTEXCLVAT');
                if DocumentValue.GET(Document."No.", true, Field1.Code, 0) then
                    if DocumentValue."Value (Decimal)" < 0 then
                        CaptureMgt.UpdateFieldValue(Document."No.", 0, 0, Field1, DelChr(DocumentValue."Value (Text)", '<', '-'), TRUE, true);

                Field1.Get(Document."Template No.", Field1.Type::Header, 'VATAMOUNT');
                if DocumentValue.GET(Document."No.", true, Field1.Code, 0) then
                    if DocumentValue."Value (Decimal)" < 0 then
                        CaptureMgt.UpdateFieldValue(Document."No.", 0, 0, Field1, DelChr(DocumentValue."Value (Text)", '<', '-'), TRUE, true);

            END;
        END;
    end;
}