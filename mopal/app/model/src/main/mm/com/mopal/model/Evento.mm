package com.mopal.model schema data;


entity Evento described_by descripcion searchable by {descripcion} {
    descripcion        : String;
    tipoEvento         : TipoEvento;
    activo             : Boolean;
    montoSoltero       : Decimal(10, 2), optional;
    montoMatrimonio    : Decimal(10, 2), optional;
    montoNiño          : Decimal(10, 2), optional;
    montoNiñosDescuento : Decimal(10, 2), optional;
}




