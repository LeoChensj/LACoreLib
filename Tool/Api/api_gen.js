var fs = require('fs');

fs.readFile('./model.json', function (err, data) {
	if(err)
	{
		return console.log('读取json文件失败');
	}

	var json = data.toString();
	var model = JSON.parse(json);

	var class_name = model.class_name;
	var super_class_name = model.super_class_name;
	var url = model.url;
	var method = model.method;
	var param = model.param;






	//创建.h文件
	fs.open('./' + class_name + '.h', 'w+', function (err, fd) {
		if(err)
		{
			return console.log('创建或打开.h文件失败文件');
		}



		var content_h = create_pre_content(class_name, super_class_name);

		content_h += '#import "' + super_class_name + '.h"\n';
		content_h += '\n';
		content_h += '@interface ' + class_name + ' : ' + super_class_name + '\n';
		content_h += '\n';


		if (param != null && Object.keys(param).length)
		{
			content_h += create_init_def(param);

			content_h += ';';
		}

		content_h += '\n';
		content_h += '\n';
		content_h += '@end\n';


		//写入数据
		fs.writeFile('./' + class_name + '.h', content_h, function (err) {
			if(err)
			{
				return console.log('.h写入数据失败');
			}

			console.log(class_name + '.h文件生成成功');

		});

	});




	//创建.m文件
	fs.open('./' + class_name + '.m', 'w+', function (err, fd) {
		if(err)
		{
			return console.log('创建或打开.m文件失败文件');
		}



		var content_m = create_pre_content(class_name, super_class_name);

		content_m += '#import "' + class_name + '.h"\n\n';
		content_m += '@interface ' + class_name + ' ()\n';
		

		if (param != null && Object.keys(param).length)
		{
			content_m += '{\n';

			var keys = Object.keys(param);
			for (var i = 0; i < keys.length; i++)
			{
				var key = keys[i];
				var value = param[key];
				var OC_type  = OC_type_for_value(value);

				content_m += '	' + OC_type + ' _' + key + ';\n';
			}

			content_m += '}\n';
		}

		content_m += '@end\n\n';



		content_m += '@implementation ' + class_name + '\n\n';


		if (param != null && Object.keys(param).length)
		{
			content_m += create_init_def(param);
			content_m += '\n{\n';
			content_m += '	if(self = [super init])\n';
			content_m += '	{\n';

			var keys = Object.keys(param);
			for (var i = 0; i < keys.length; i++)
			{
				var key = keys[i];
				var value = param[key];
				var OC_type  = OC_type_for_value(value);

				content_m += '		_' + key + ' = ' + key + ';\n';
			}

			content_m += '	}\n\n';

			content_m += '	return self;\n';

			content_m += '}\n\n';
		}


		content_m += '- (NSString *)configRequestUrl\n';
		content_m += '{\n';
		content_m += '	return @"' + url + '";\n';
		content_m += '}\n\n';



		content_m += '- (LARequestMethod)configRequestMethod\n';
		content_m += '{\n';

		var method_str;
		if(method.toLowerCase() == 'get')
		{
			method_str = 'LARequestMethodGet';
		}
		else if(method.toLowerCase() == 'post')
		{
			method_str = 'LARequestMethodPost';
		}
		else if(method.toLowerCase() == 'head')
		{
			method_str = 'LARequestMethodHead';
		}
		else if(method.toLowerCase() == 'put')
		{
			method_str = 'LARequestMethodPut';
		}
		else if(method.toLowerCase() == 'delete')
		{
			method_str = 'LARequestMethodDelete';
		}
		else if(method.toLowerCase() == 'patch')
		{
			method_str = 'LARequestMethodPatch';
		}

		content_m += '	return ' + method_str + ';\n';
		content_m += '}\n\n';



		if (param != null && Object.keys(param).length)
		{
			content_m += '- (NSDictionary *)configRequestParam\n';
			content_m += '{\n';

			var keys = Object.keys(param);
			for (var i = 0; i < keys.length; i++)
			{
				var key = keys[i];
				var value = param[key];
				var OC_type  = OC_type_for_value(value);

				var key_value;
				if(OC_type == 'NSString *')
				{
					key_value = '_' + key;
				}
				else
				{
					key_value = '@(_' + key + ')';
				}


				if(i == 0)
				{
					content_m += '	return @{@"' + key + '": ' + key_value;
				}
				else
				{
					content_m += ', @"' + key + '": ' + key_value;
				}
			}

			content_m += '};\n';
			content_m += '}\n\n';
		}














		content_m += '@end\n';


		//写入数据
		fs.writeFile('./' + class_name + '.m', content_m, function (err) {
			if(err)
			{
				return console.log('.m写入数据失败');
			}

			console.log(class_name + '.m文件生成成功');

		});



	});







});






function OC_type_for_value(value) {

	if(typeof(value) == 'number')
	{
		return 'NSInteger';
	}
	else if(typeof(value) == 'boolean')
	{
		return 'BOOL';
	}
	else if(typeof(value) == 'string')
	{
		return 'NSString *';
	}


	return 'NSString *';
}




function create_pre_content(class_name, super_class_name) {

	var content = '//\n';
	content += '//  ' + class_name + '.h\n';
	content += '//\n';
	content += '//\n';
	content += '//  Copyright © Leo.Chen All rights reserved.\n';
	content += '//\n';
	content += '\n';

	return content;
}

function create_init_def(param) {

	var content = '- (instancetype)init_with_';

	var keys = Object.keys(param);

	for (var i = 0; i < keys.length; i++)
	{
		var key = keys[i];
		var value = param[key];
		var OC_type  = OC_type_for_value(value);

		if(i == 0)
		{
			content += key + ':(' + OC_type + ')' + key;
		}
		else
		{
			content += ' ' + key + ':(' + OC_type + ')' + key;
		}
	}

	return content;

}























