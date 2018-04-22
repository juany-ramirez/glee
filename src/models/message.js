module.exports = function (sequelize, DataTypes){
    const Message = sequelize.define(
        "Message",
        {
            title: DataTypes.STRING,
            mensaje: DataTypes.STRING,
            public: DataTypes.BOOLEAN,
        },
        {
            associate(models){

            }
        }
    );
    return Message;
};