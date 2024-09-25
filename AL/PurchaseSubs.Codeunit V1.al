codeunit 60120 "CDC Purchase Subs."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDC Purch. - Val. Purch. Ord.", 'OnAfterValidatePurchaseOrder', '', true, true)]
    local procedure OnAfterValidatePurchaseOrder(var Document: Record "CDC Document")
    var
        Field: Record "CDC Template Field";
        CaptureMgt: Codeunit "CDC Capture Management";
        PurchDocMgt: Codeunit "CDC Purch. Doc. - Management";
        DocType: Integer;
        TextInvoice: TextConst ENU = 'I', ESP = 'F';
        TextCrMemo: TextConst ENU = 'Cr', ESP = 'A';
    begin
        Field.GET(Document."Template No.", Field.Type::Header, 'AMOUNTINCLVAT');
        IF CaptureMgt.GetDecimal(Document, Field.Type, Field.Code, 0) >= 0 THEN BEGIN
            IF Field.GET(Document."Template No.", Field.Type::Header, 'DOCTYPE') THEN
                CaptureMgt.UpdateFieldValue(Document."No.", 0, 0, Field, TextInvoice, TRUE, true)
        END ELSE BEGIN
            IF Field.GET(Document."Template No.", Field.Type::Header, 'DOCTYPE') THEN
                CaptureMgt.UpdateFieldValue(Document."No.", 0, 0, Field, TextCrMemo, TRUE, true);
        END;
    end;
}