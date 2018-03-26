package com.mopal.view;


import com.mopal.model.PersonaRelacionada;
import org.jetbrains.annotations.NotNull;
import tekgenesis.common.core.DateOnly;
import tekgenesis.form.Action;

import static com.mopal.view.PersonaRelacionadaFormBase.Field.*;
import static tekgenesis.common.core.DateOnly.current;

/** User class for form: PersonaRelacionadaForm */
public class PersonaRelacionadaForm extends PersonaRelacionadaFormBase {
    @NotNull
    @Override
    public Action updateEdad() {
        setEdadValue(calcularEdad(getFechaNacimiento()));
        return actions().getDefault();
    }

    @NotNull
    @Override
    public Action saveData() {
        if(!isDefined(NOMBRE) || !isDefined(APELLIDO) || !isDefined(FECHA_NACIMIENTO) || !isDefined(GRUPO_REFERENCIA))
            return actions().getError().withMessage("Se deben cargar los campos necesarios para continuar");

        if(getId() == null){
            final PersonaRelacionada personaRelacionada = copyTo(PersonaRelacionada.create());
            personaRelacionada.insert();
        } else {
            final PersonaRelacionada personaRelacionada = copyTo(PersonaRelacionada.find(getId()));
            personaRelacionada.update();
        }

        loadPersonasRelacionadas();

        resetForm();

        return actions.getDefault();
    }

    private PersonaRelacionada copyTo(final PersonaRelacionada personaRelacionada) {
        personaRelacionada.setPersona(getPersonaResponsable());
        personaRelacionada.setNombre(getNombre());
        personaRelacionada.setApellido(getApellido());
        personaRelacionada.setFechaNacimiento(getFechaNacimiento());
        personaRelacionada.setGrupoReferencia(getGrupoReferencia());
        personaRelacionada.setAsistenciaJueves(isAsistenciaJueves());
        personaRelacionada.setAsistenciaViernes(isAsistenciaViernes());
        personaRelacionada.setAsistenciaSabado(isAsistenciaSabado());
        personaRelacionada.setObservaciones(getObservaciones());

        return personaRelacionada;
    }

    private void populateForm(final PersonaRelacionada personaRelacionada) {
        resetForm();

        setId(personaRelacionada.getId());
        setNombre(personaRelacionada.getNombre());
        setApellido(personaRelacionada.getApellido());
        setFechaNacimiento(personaRelacionada.getFechaNacimiento());
        setGrupoReferencia(personaRelacionada.getGrupoReferencia());
        setAsistenciaJueves(personaRelacionada.isAsistenciaJueves());
        setAsistenciaViernes(personaRelacionada.isAsistenciaViernes());
        setAsistenciaSabado(personaRelacionada.isAsistenciaSabado());
        setObservaciones(personaRelacionada.getObservaciones());
    }

    private void resetForm() {
        reset(NOMBRE);
        reset(APELLIDO);
        reset(FECHA_NACIMIENTO);
        reset(EDAD_VALUE);
        reset(GRUPO_REFERENCIA);
        reset(ASISTENCIA_JUEVES);
        reset(ASISTENCIA_VIERNES);
        reset(ASISTENCIA_SABADO);
        reset(OBSERVACIONES);
    }

    private String calcularEdad(final DateOnly fecha) {
        return String.valueOf(current().yearsFrom(fecha)) + " años";
    }

    public void loadPersonasRelacionadas() {
        getPersonasAsignadas().clear();

        getPersonaResponsable().getPersonasRelacionadas().forEach(personaRelacionada -> {
            final PersonasAsignadasRow personaAsignadasRow = getPersonasAsignadas().add();

            personaAsignadasRow.setIdPersonaRelacionada(personaRelacionada.getId());
            personaAsignadasRow.setNombrePersona(personaRelacionada.getNombre());
            personaAsignadasRow.setApellidoPersona(personaRelacionada.getApellido());
            personaAsignadasRow.setEdad(calcularEdad(personaRelacionada.getFechaNacimiento()));
            personaAsignadasRow.setGrupoReferenciaPersona(personaRelacionada.getGrupoReferencia());
            personaAsignadasRow.setColAsistenciaJueves(personaRelacionada.isAsistenciaJueves());
            personaAsignadasRow.setColAsistenciaViernes(personaRelacionada.isAsistenciaViernes());
            personaAsignadasRow.setColAsistenciaSabado(personaRelacionada.isAsistenciaSabado());

            getPersonasAsignadas().append(personaAsignadasRow);
        });
    }

    public class PersonasAsignadasRow extends PersonasAsignadasRowBase {
        @NotNull
        @Override
        public Action editarPersona() {
            populateForm(PersonaRelacionada.find(getIdPersonaRelacionada()));
            return actions().getDefault();
        }

        @NotNull
        @Override
        public Action quitarPersona() {
            resetForm();

            final PersonaRelacionada personaRelacionada = PersonaRelacionada.find(getIdPersonaRelacionada());
            personaRelacionada.delete();

            loadPersonasRelacionadas();

            return actions().getDefault();
        }
    }
}
