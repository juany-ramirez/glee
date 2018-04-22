module.exports = {
    up(queryInterface, Sequelize){
        return queryInterface.createTable('Messages',{
            id:{
                allowNull: false,
                autoIncrement: true,
                primaryKey: true,
                type: Sequelize.INTEGER
            },
            title:{
                allowNull: false,   
                type: Sequelize.STRING
            },
            mensaje:{
                allowNull: false,
                type: Sequelize.STRING
            },
            public:{
                allowNull: false,
                type: Sequelize.BOOLEAN
            }
        });
    },
    down(queryInterface, Sequelize){
        return queryInterface.dropTable('Messages');
    }
};