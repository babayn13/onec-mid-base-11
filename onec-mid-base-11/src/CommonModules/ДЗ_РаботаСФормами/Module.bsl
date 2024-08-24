#Область ПрограммныйИнтерфейс

// Дополняет форму полями и командами заказчика
Процедура ДополнитьФорму(Форма) Экспорт
	
	ИмяФормы = Форма.ИмяФормы;
	
	Если ИмяФормы = "Документ.ЗаказПокупателя.Форма.ФормаДокумента" Тогда
		
		ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма);
		ДобавитьГруппаСогласованнаяСкидка(Форма);
		ДобавитьПолеСогласованнаяСкидкаВГруппаСогласованнаяСкидка(Форма);
		ДобавитьКомандаПересчитатьСкидку(Форма);
		
	ИначеЕсли ИмяФормы = "Документ.ПоступлениеТоваровУслуг.Форма.ФормаДокумента" Тогда
		
		ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма);
		
	ИначеЕсли ИмяФормы = "Документ.РеализацияТоваровУслуг.Форма.ФормаДокумента" Тогда
		
		ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма);
		
	ИначеЕсли ИмяФормы = "Документ.ОплатаОтПокупателя.Форма.ФормаДокумента" Тогда
		
		ДобавитьПолеКонтактноеЛицоПередСуммаДокумента(Форма);
		
	ИначеЕсли ИмяФормы = "Документ.ОплатаПоставщику.Форма.ФормаДокумента" Тогда
		
		ДобавитьПолеКонтактноеЛицоПередСуммаДокумента(Форма);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма)
	
	ПолеВвода = Форма.Элементы.Добавить("КонтактноеЛицо", Тип("ПолеФормы"), Форма.Элементы.ГруппаШапкаПраво);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.ДЗ_КонтактноеЛицо";
	
КонецПроцедуры

Процедура ДобавитьПолеКонтактноеЛицоПередСуммаДокумента(Форма)
	
	ПолеВвода = Форма.Элементы.Вставить("КонтактноеЛицо", Тип("ПолеФормы"), Форма, Форма.Элементы.СуммаДокумента);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект.ДЗ_КонтактноеЛицо";
	
КонецПроцедуры

Процедура ДобавитьГруппаСогласованнаяСкидка(Форма)
	
	ГруппаСогласованнаяСкидка = Форма.Элементы.Добавить("ГруппаСогласованнаяСкидка", Тип("ГруппаФормы"), Форма.Элементы.ГруппаШапкаЛево);
	ГруппаСогласованнаяСкидка.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаСогласованнаяСкидка.Отображение = ОтображениеОбычнойГруппы.Нет;
	ГруппаСогласованнаяСкидка.ОтображатьЗаголовок = ЛОЖЬ; 
	ГруппаСогласованнаяСкидка.Группировка = ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
	
КонецПроцедуры

Процедура ДобавитьПолеСогласованнаяСкидкаВГруппаСогласованнаяСкидка(Форма)
	
	ПолеВвода = Форма.Элементы.Добавить("СогласованнаяСкидка", Тип("ПолеФормы"), Форма.Элементы.ГруппаСогласованнаяСкидка);
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.РастягиватьПоГоризонтали = Истина;
	ПолеВвода.ПутьКДанным = "Объект.ДЗ_СогласованнаяСкидка";
	ПолеВвода.УстановитьДействие("ПриИзменении", "ДействиеПриИзменении");
	
КонецПроцедуры

Процедура ДобавитьКомандаПересчитатьСкидку(Форма) Экспорт
	
	КомандаПересчитать = Форма.Команды.Добавить("Пересчитать");
	КомандаПересчитать.Действие = "ПересчитатьСуммуСтрок";
	КомандаПересчитать.Заголовок = "Пересчитать";
	КнопкаПересчитать = Форма.Элементы.Добавить("Пересчитать", Тип("КнопкаФормы"), Форма.Элементы.ГруппаСогласованнаяСкидка);
	КнопкаПересчитать.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
	КнопкаПересчитать.ИмяКоманды = "Пересчитать";
	
КонецПроцедуры

Процедура ПересчитатьСуммуСтрок(Форма) Экспорт
	
	Скидка = Форма.Объект.ДЗ_СогласованнаяСкидка;
	
	Для Каждого СтрокаТЧ Из Форма.Объект.Товары Цикл
		
		СтрокаТЧ.Сумма = СтрокаТЧ.Количество * (СтрокаТЧ.Цена - СтрокаТЧ.Цена * Скидка / 100);
		
	КонецЦикла;
	
	Для Каждого СтрокаТЧ Из Форма.Объект.Услуги Цикл
		
		СтрокаТЧ.Сумма = СтрокаТЧ.Количество * (СтрокаТЧ.Цена - СтрокаТЧ.Цена * Скидка / 100);
		
	КонецЦикла;

КонецПроцедуры 

#КонецОбласти