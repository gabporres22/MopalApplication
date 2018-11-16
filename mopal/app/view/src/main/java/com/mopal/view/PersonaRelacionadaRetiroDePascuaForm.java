package com.mopal.view;

import com.mopal.model.AsistenteRetiroPascua;
import com.mopal.model.PRRetiroPascua;
import com.mopal.model.g.AsistenteRetiroPascuaBase;
import com.mopal.model.g.PRRetiroPascuaBase;
import tekgenesis.common.core.DateOnly;
import tekgenesis.form.Action;
import org.jetbrains.annotations.NotNull;

import static com.mopal.model.g.AsistenteRetiroPascuaBase.find;
import static com.mopal.model.g.PRRetiroPascuaBase.find;
import static tekgenesis.common.core.DateOnly.current;

/** User class for form: PersonaRelacionadaRetiroDePascuaForm */
public class PersonaRelacionadaRetiroDePascuaForm extends PersonaRelacionadaRetiroDePascuaFormBase {

    //~ Methods ..................................................................................................................

    /** Invoked when date_box(fechaNacimiento) value ui changes */
    @Override @NotNull public Action updateEdad() {
        setEdadValue(calcularEdad(getFechaNacimiento()));
        return actions().getDefault();
    }

    /** Invoked when button(saveButton) is clicked */
    @Override @NotNull public Action saveData() {
        if(!isDefined(Field.NOMBRE) || !isDefined(Field.APELLIDO) || !isDefined(Field.FECHA_NACIMIENTO) || !isDefined(Field.GRUPO_REFERENCIA))
            return actions().getError().withMessage("Se deben cargar los campos necesarios para continuar");

        if(getId() == null){
            final PRRetiroPascua personaRelacionada = copyTo(PRRetiroPascua.create());
            personaRelacionada.insert();
        } else {
            final PRRetiroPascua personaRelacionada = copyTo(find(getId()));
            personaRelacionada.update();
        }

        loadPersonasRelacionadas();

        resetForm();

        return actions.getDefault();
    }

    private String calcularEdad(final DateOnly fecha) {
        return String.valueOf(current().yearsFrom(fecha)) + " años";
    }

    private PRRetiroPascua copyTo(final PRRetiroPascua personaRelacionada) {
        final AsistenteRetiroPascua asistenteRetiroPascua = find(getIdEvento(), getAsistenteResponsable().getId());

        personaRelacionada.setPersonaRelacionada(asistenteRetiroPascua);
        personaRelacionada.setNombre(getNombre());
        personaRelacionada.setApellido(getApellido());
        personaRelacionada.setFechaNacimiento(getFechaNacimiento());
        personaRelacionada.setGrupoReferencia(getGrupoReferencia());
        personaRelacionada.setObservaciones(getObservaciones());

        return personaRelacionada;
    }

    private void populateForm(final PRRetiroPascua personaRelacionada) {
        resetForm();

        setId(personaRelacionada.getId());
        setNombre(personaRelacionada.getNombre());
        setApellido(personaRelacionada.getApellido());
        setFechaNacimiento(personaRelacionada.getFechaNacimiento());
        setGrupoReferencia(personaRelacionada.getGrupoReferencia());
        setObservaciones(personaRelacionada.getObservaciones());
    }

    private void resetForm() {
        reset(Field.ID);
        reset(Field.NOMBRE);
        reset(Field.APELLIDO);
        reset(Field.FECHA_NACIMIENTO);
        reset(Field.EDAD_VALUE);
        reset(Field.GRUPO_REFERENCIA);
        reset(Field.OBSERVACIONES);
    }

    public void loadPersonasRelacionadas() {
        getPersonasAsignadas().clear();

        find(getIdEvento(), getAsistenteResponsable().getId()).getPersonasRelacionadas().forEach(personaRelacionada -> {
            final PersonasAsignadasRow personaAsignadasRow = getPersonasAsignadas().add();

            personaAsignadasRow.setIdPersonaRelacionada(personaRelacionada.getId());
            personaAsignadasRow.setNombrePersona(personaRelacionada.getNombre());
            personaAsignadasRow.setApellidoPersona(personaRelacionada.getApellido());
            personaAsignadasRow.setEdad(calcularEdad(personaRelacionada.getFechaNacimiento()));
            personaAsignadasRow.setGrupoReferenciaPersona(personaRelacionada.getGrupoReferencia());

            getPersonasAsignadas().append(personaAsignadasRow);
        });
    }

    //~ Inner Classes ............................................................................................................

    public class PersonasAsignadasRow extends PersonasAsignadasRowBase {

        //~ Methods ..................................................................................................................

        /** Invoked when label(editarPersona) is clicked */
        @Override @NotNull public Action editarPersona() {
            populateForm(find(getIdPersonaRelacionada()));
            return actions().getDefault();
        }

        /** Invoked when label(quitarPersona) is clicked */
        @Override @NotNull public Action quitarPersona() {
            resetForm();

            final PRRetiroPascua personaRelacionada = find(getIdPersonaRelacionada());
            personaRelacionada.delete();

            loadPersonasRelacionadas();

            return actions().getDefault();
        }
    }
}
