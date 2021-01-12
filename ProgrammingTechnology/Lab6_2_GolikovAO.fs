// Создание формы Windows Forms: Работа с базой данных Microsoft Access
open System
open System.Windows.Forms
open System.Drawing
open System.Data
open System.Data.OleDb

// Создаём шрифт
let ffont = new Font("Verdana", 9.75F,FontStyle.Regular, GraphicsUnit.Point)  
// Создаём объект соединения с базой данных
let oleconn = new System.Data.OleDb.OleDbConnection("Provider = Microsoft.Jet.OLEDB.4.0;
  Data Source = Работники.mdb")
// СоздаёмOleDbDataAdapter
let mutable dataAdpter4 = new System.Data.OleDb.OleDbDataAdapter("Select * from [Главная таблица]", oleconn)
// Генерируем DataSet
let dataSet4 = new DataSet()
//fills the dataset with recod values
dataAdpter4.Fill(dataSet4,"[Главная таблица]") |> ignore
// Создаём форму и элементы управления
let dataForm = new Form(Text = "Различные примеры (F#) :: Работа с базой данных Microsoft Access", AutoScaleDimensions = new System.Drawing.SizeF(60.0F, 13.0F), ClientSize = new System.Drawing.Size(500, 550), StartPosition = FormStartPosition.CenterScreen)
let exitButton4 = new Button(Text = "Выход", Location = new System.Drawing.Point(300, 500)) 
let searchButton4 = new Button(Text = "Поиск", Location = new System.Drawing.Point(220, 500))  
let searchButton5 = new Button(Text = "Sort", Location = new System.Drawing.Point(20, 500)) 
let searchButton6 = new Button(Text = "Sort 2", Location = new System.Drawing.Point(90, 500))
let label14 = new Label(Text = "Введите Номер или Фамилию:", Location  =  new System.Drawing.Point(0, 10), AutoSize = true)
let label24 = new Label(Text = "Номер:", Location  =  new System.Drawing.Point(0, 50), AutoSize = true)
let label34 = new Label(Text = "Имя:", Location  =  new System.Drawing.Point(0,100), AutoSize = true)
let label44 = new Label(Text = "Фамилия:", Location = new System.Drawing.Point(0,150), AutoSize = true)
let label54 = new Label(Text = "Возраст:", Location = new System.Drawing.Point(0,200), AutoSize = true)
let textBoxNumber4 = new TextBox(Location = new System.Drawing.Point(300,10))
let labelNumber4 = new Label(Location = new System.Drawing.Point(100,50), BorderStyle = BorderStyle.FixedSingle)
let labelFirstName4 = new Label(Location = new System.Drawing.Point(100,100), BorderStyle = BorderStyle.FixedSingle)
let labelLastName4 = new Label(Location = new System.Drawing.Point(100,150), BorderStyle = BorderStyle.FixedSingle)
let labelAge4 = new Label(Location = new System.Drawing.Point(100,200), BorderStyle = BorderStyle.FixedSingle)
// Создаём DataGridView
let dataGridView4 = new DataGridView(ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize,Size = new System.Drawing.Size(480, 200), Location = new System.Drawing.Point(10, 250))
// Создаём столбцы DataGridView
let chrnumbercol = new DataGridViewTextBoxColumn()
let chrfnamecol = new DataGridViewTextBoxColumn()
let chrlnamecol = new DataGridViewTextBoxColumn()
// Добавляем столбцы в dataGridView4
dataGridView4.Columns.Add(chrnumbercol) |> ignore
dataGridView4.Columns.Add(chrfnamecol) |> ignore
dataGridView4.Columns.Add(chrlnamecol) |> ignore
// определяем связь
dataGridView4.DataSource <- dataSet4.Tables.["[Главная таблица]"]
// Применяем шрифт для формы
dataForm.Font <- ffont
// Применям связь данных базы с DataGridView (имя стоблца в базе / имя столбца в элементе)
chrnumbercol.DataPropertyName <- "Номер"
chrnumbercol.HeaderText <- "Номер"
chrfnamecol.DataPropertyName<-"Имя"
chrfnamecol.HeaderText<-"Имя работника"
chrlnamecol.DataPropertyName<-"Фамилия"
chrlnamecol.HeaderText<-"Фамилия работника"
// Добавляем элементы на форму
dataForm.Controls.Add(dataGridView4)
dataForm.Controls.Add(exitButton4)
dataForm.Controls.Add(searchButton4)
dataForm.Controls.Add(searchButton5)
dataForm.Controls.Add(searchButton6)
dataForm.Controls.Add(label14)
dataForm.Controls.Add(label24)
dataForm.Controls.Add(label34)
dataForm.Controls.Add(label44)
dataForm.Controls.Add(label54)
dataForm.Controls.Add(textBoxNumber4)
dataForm.Controls.Add(labelNumber4)
dataForm.Controls.Add(labelFirstName4)
dataForm.Controls.Add(labelLastName4)
dataForm.Controls.Add(labelAge4)
// Связываем Label'ы со столбцами базы данных
labelNumber4.Text <- Convert.ToString(dataSet4.Tables.["[Главная таблица]"].Rows.Item(0).Item(0))
labelFirstName4.Text <- Convert.ToString(dataSet4.Tables.["[Главная таблица]"].Rows.Item(0).Item(1))
labelLastName4.Text <- Convert.ToString(dataSet4.Tables.["[Главная таблица]"].Rows.Item(0).Item(2))
labelAge4.Text <- Convert.ToString(dataSet4.Tables.["[Главная таблица]"].Rows.Item(0).Item(3))


searchButton4.Click.Add(fun search->  
                    // Обрабатываем номер строки индекса            
                    let mutable introws = 0
                    // Определяем, была найдена запись или нет
                    let mutable blnfound = false   
                    // Обрабатываем общее количество записей              
                    let mutable inttotrec = Convert.ToInt32(dataSet4.Tables.["[Главная таблица]"].Rows.Count)
                    // Обрабатываем данные вводимые пользователем
                    let strtext = Convert.ToString(textBoxNumber4.Text)
                    // До тех пор, пока совпадений не найдено и конец записей не достигнут
                    while((blnfound = false) && (introws <= inttotrec-1)) do
                         let strempnum = Convert.ToString(dataSet4.Tables.["[Главная таблица]"].Rows.Item(introws).Item(0))
                         let strempnum1 = Convert.ToString(dataSet4.Tables.["[Главная таблица]"].Rows.Item(introws).Item(2))
                         // Сравниваем данные введённые в TextBox пользователем с нашей таблицей ("Номер")
                         // Если есть совпадений, отображаем результат запроса
                         if strtext.ToUpper() = strempnum.ToUpper() || strtext.ToUpper() = strempnum1.ToUpper() then
                            blnfound<-true
                            labelNumber4.Text <- Convert.ToString(dataSet4.Tables.["[Главная таблица]"].Rows.Item(introws).Item(0))
                            labelFirstName4.Text <- Convert.ToString(dataSet4.Tables.["[Главная таблица]"].Rows.Item(introws).Item(1))
                            labelLastName4.Text <- Convert.ToString(dataSet4.Tables.["[Главная таблица]"].Rows.Item(introws).Item(2)) 
                            labelAge4.Text <- Convert.ToString(dataSet4.Tables.["[Главная таблица]"].Rows.Item(introws).Item(3)) 
                         // Сравниваем со следующей запись до появления совпадений
                         introws<-introws + 1    
                    // Если совпадения не найдены     
                    if blnfound = false then
                        MessageBox.Show("Запись не найдена!", "Работа с базой данных Microsoft Access :: Сообщение об ошибке", MessageBoxButtons.OK, MessageBoxIcon.Information) |> ignore)                       

exitButton4.Click.Add(fun exit->
                    dataForm.Close()
                    oleconn.Close()) 

 // Функции сортировки по фамилии и тех, кто старше 30
let clean1 (n : DataGridView) = while (n.Rows.Count > 1) do  n.Rows.RemoveAt(0)
searchButton5.Click.Add (fun sort ->
                                  clean1 dataGridView4
                                  dataAdpter4 <- new System.Data.OleDb.OleDbDataAdapter("Select * from [Главная таблица] order by [Фамилия],[Возраст]", oleconn)
                                  dataAdpter4.Fill(dataSet4,"[Главная таблица]") |> ignore)
searchButton6.Click.Add (fun sort ->
                                  clean1 dataGridView4
                                  dataAdpter4 <- new System.Data.OleDb.OleDbDataAdapter("Select * from [Главная таблица] where [Возраст] > 30 order by [Фамилия]", oleconn)
                                  dataAdpter4.Fill(dataSet4,"[Главная таблица]") |> ignore)


Application.Run(dataForm)
