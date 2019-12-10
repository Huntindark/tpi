# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

	User.create(username: 'default', passwd: 'default')
	products = Product.create([{unicode: 'acb123456', name: 'Agua', detail: 'Agua minera', desc: 'Eco de los Andes', basePrice: 25}, {unicode: 'zzz987654', name: 'Sal', detail: 'Fina', desc: 'Selusal', basePrice: 20}])
	Item.create([{product_id: products.first.id, status: 'Disponible'},{product_id: products.first.id, status: 'Disponible'},{product_id: products.first.id, status: 'Disponible'},{product_id: products.last.id, status: 'Disponible'},{product_id: products.last.id, status: 'Disponible'},{product_id: products.last.id, status: 'Disponible'}] )
	ivatypes = Ivatype.create( [ { description: 'IVA Responsable Inscripto' },{ description: 'IVA Responsable no Inscripto'},{ description: 'IVA no Responsable'}, { description: 'IVA Sujeto Exento'},{ description: 'Consumidor Final'},{ description: 'Responsable Monotributo'},{ description:'Sujeto no Categorizado' }, { description:'Proveedor del Exterior' },{ description:'Cliente del Exterior' },{ description: 'IVA Liberado  Ley Nº 19.640'},{ description:'IVA Responsable Inscripto  Agente de Percepción' },{ description:'Pequeño Contribuyente Eventual' },{ description: 'Monotributista Social'},{ description: 'Pequeño Contribuyente Eventual Social'}, ] )
	client = Client.create(ci: '5546854', name: 'El chico de la vuelta', ivatype_id: ivatypes.first.id, email: 'elchico@dela.vuelta')
	Phone.create(client_id: client.id, number: 4564056)














