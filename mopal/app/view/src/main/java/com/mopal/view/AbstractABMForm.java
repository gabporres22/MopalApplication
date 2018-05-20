package com.mopal.view;

import com.mopal.model.Evento;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;

import static com.mopal.model.TipoEvento.JORNADA_PENTECOSTES;
import static com.mopal.model.TipoEvento.RETIRO_DE_PASCUA;
import static com.mopal.model.g.EventoBase.findWhere;
import static com.mopal.model.g.EventoTable.EVENTO;

/** User class for form: AbstractABMForm */
public class AbstractABMForm extends AbstractABMFormBase {
    @NotNull
    @Override
    public Action redirect() {
        final Evento evento = findWhere(EVENTO.ACTIVO.eq(true));

        if(evento != null){
            if(evento.getTipoEvento().equals(JORNADA_PENTECOSTES)){
                final AsistenteJornadaPentecostesForm jornadaPentecostesForm = forms.initialize(AsistenteJornadaPentecostesForm.class);
                jornadaPentecostesForm.setEvento(evento);
                return actions().navigate(jornadaPentecostesForm);
            } else if (evento.getTipoEvento().equals(RETIRO_DE_PASCUA)) {
                final AsistenteRetiroPascuaForm retiroPascuaForm = forms.initialize(AsistenteRetiroPascuaForm.class);
                retiroPascuaForm.setEvento(evento);
                return actions().navigate(retiroPascuaForm);
            }
        }

        return actions().getError().withMessage("No hay un Evento activo");
    }
}
