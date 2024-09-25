CU 60120 – Esta codeunit se suscribe al evento OnBforeCalculationDueDate de la codeunit Full Capture (es el evento disponible que mejor me venía, ya que se ejecuta justo después de actualizar la F o la A). 
El código lo que hace es mirar si el importe factura es negativo y en caso de serlo, pone una A y actualiza la base imponible, el importe del IVA y el total de la factura a positivo. 
Para que funcione correctamente hay que desmarcar, por lo menos en el campo de total factura (importe Incl. IVA) el campo de “Calcular Valor absoluto” para que lo lea en negativo). Este campo es opcional desmarcarlo en la base imponible y en el importe IVA.

