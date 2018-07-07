alter  table QName(DATA, COMUNIDAD_PASTOR)
	AddColumn(CREATION_TIME                     datetime(3)      default CurrentTime not null);;

alter  table QName(DATA, COMUNIDAD_PASTOR)
	AddColumn(CREATION_USER                     nvarchar(100));;

alter  table QName(DATA, COMUNIDAD_PASTOR)
	AddColumn(UPDATE_USER                       nvarchar(100));;

alter  table QName(DATA, DETALLE_ASISTENCIA_ENCUENTRO)
	AddColumn(DEPRECATION_TIME                  datetime(3));;

alter  table QName(DATA, DETALLE_ASISTENCIA_ENCUENTRO)
	AddColumn(DEPRECATION_USER                  nvarchar(100));;

alter  table QName(DATA, DETALLE_ASISTENCIA_ENCUENTRO)
	AddColumn(CREATION_TIME                     datetime(3)      default CurrentTime not null);;

alter  table QName(DATA, DETALLE_ASISTENCIA_ENCUENTRO)
	AddColumn(CREATION_USER                     nvarchar(100));;

alter  table QName(DATA, DETALLE_ASISTENCIA_ENCUENTRO)
	AddColumn(UPDATE_USER                       nvarchar(100));;

alter  table QName(DATA, DETALLE_ASISTENCIA_ENCUENTRO)
	SetDefault(OBSERVACIONES, null);;

alter  table QName(DATA, DETALLE_ASISTENCIA_ENCUENTRO)
	DropNotNull(OBSERVACIONES);;

alter  table QName(DATA, ENCUENTRO)
	AddColumn(DEPRECATION_TIME                  datetime(3));;

alter  table QName(DATA, ENCUENTRO)
	AddColumn(DEPRECATION_USER                  nvarchar(100));;

alter  table QName(DATA, ENCUENTRO)
	AddColumn(CREATION_TIME                     datetime(3)      default CurrentTime not null);;

alter  table QName(DATA, ENCUENTRO)
	AddColumn(CREATION_USER                     nvarchar(100));;

alter  table QName(DATA, ENCUENTRO)
	AddColumn(UPDATE_USER                       nvarchar(100));;

alter  table QName(DATA, ENCUENTRO)
	AlterColumnType(FECHA_ENCUENTRO, date);;

alter  table QName(DATA, ENCUENTRO)
	SetDefault(FECHA_ENCUENTRO, CurrentDate);;

alter  table QName(DATA, ENCUENTRO)
	SetDefault(OBSERVACIONES, null);;

alter  table QName(DATA, ENCUENTRO)
	DropNotNull(OBSERVACIONES);;

alter  table QName(DATA, USUARIO_ASISTENTE)
	AddColumn(CREATION_TIME                     datetime(3)      default CurrentTime not null);;

alter  table QName(DATA, USUARIO_ASISTENTE)
	AddColumn(CREATION_USER                     nvarchar(100));;

alter  table QName(DATA, USUARIO_ASISTENTE)
	AddColumn(UPDATE_USER                       nvarchar(100));;

