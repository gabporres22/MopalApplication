package com.mopal.view;


import com.mopal.model.Evento;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;

import static com.mopal.model.TipoEvento.JORNADA_PENTECOSTES;
import static com.mopal.model.TipoEvento.RETIRO_DE_PASCUA;
import static com.mopal.model.g.EventoBase.findWhere;
import static com.mopal.model.g.EventoTable.EVENTO;

/** User class for form: AbstractListingForm */
public class AbstractListingForm extends AbstractListingFormBase {
    @NotNull
    @Override
    public Action redirect() {
        final Evento evento = findWhere(EVENTO.ACTIVO.eq(true));

        if(evento != null){
            if(evento.getTipoEvento().equals(JORNADA_PENTECOSTES)){
                return actions().navigate(AsistenteJornadaPentecostesFormListing.class);
            } else if (evento.getTipoEvento().equals(RETIRO_DE_PASCUA)) {
                return actions().navigate(PersonaFormListing.class);
            }
        }

        return actions().getError().withMessage("No hay un Evento activo");
    }
}