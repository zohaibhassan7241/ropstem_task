import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ropstem_task/services/car_database.dart';
import 'package:ropstem_task/utils/utils.dart';
import 'package:ropstem_task/utils/validate.dart';
import 'package:ropstem_task/widgets/app_text_input.dart';
import 'package:ropstem_task/widgets/widget.dart';

class CarAddUpdate extends StatefulWidget {
  final Car? car;

  const CarAddUpdate({super.key, this.car});

  @override
  State<CarAddUpdate> createState() => _CarAddUpdateState();
}

class _CarAddUpdateState extends State<CarAddUpdate> {
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _registrationNoController = TextEditingController();
  final _colorController = TextEditingController();
  final _focusMake = FocusNode();
  final _focusModel = FocusNode();
  final _focusreg = FocusNode();
  final _focusColor = FocusNode();
  String _categoryValue = 'Compact';
  String? _errorMake;
  String? _errorModel;
  String? _errorRegis;
  String? _errorColor;

  @override
  void initState() {
    super.initState();
    if (widget.car != null) {
      _makeController.text = widget.car!.make;
      _modelController.text = widget.car!.model;
      _registrationNoController.text = widget.car!.registrationNo;
      _colorController.text = widget.car!.color;
      _categoryValue = widget.car!.category;
    }
  }

  ///Submit data for Update || Add
  void _submit() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _errorMake = UtilValidator.validate(_makeController.text, type: ValidateType.make);
      _errorModel = UtilValidator.validate(_modelController.text, type: ValidateType.model);
      _errorRegis =
          UtilValidator.validate(_registrationNoController.text, type: ValidateType.registration);
      _errorColor = UtilValidator.validate(_colorController.text, type: ValidateType.color);
    });
    if (_errorMake == null && _errorModel == null && _errorRegis == null && _errorColor == null) {
      final car = Car(
        id: widget.car?.id ?? uuid.v4(),
        make: _makeController.text,
        model: _modelController.text,
        registrationNo: _registrationNoController.text,
        color: _colorController.text,
        category: _categoryValue,
      );
      Navigator.of(context).pop(car);
    }
  }

  @override
  void dispose() {
    _makeController.dispose();
    _modelController.dispose();
    _registrationNoController.dispose();
    _colorController.dispose(); // add this line
    _focusMake.dispose();
    _focusModel.dispose();
    _focusreg.dispose();
    _focusColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car != null ? 'Edit Car' : 'Add Car'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ///Make
              Text(
                'Make',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              AppTextInput(
                hintText: 'Enter make',
                errorText: _errorMake,
                controller: _makeController,
                focusNode: _focusMake,
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  setState(() {
                    _errorMake = UtilValidator.validate(
                      _makeController.text,
                      type: ValidateType.make,
                    );
                  });
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(context, _focusMake, _focusModel);
                },
                trailing: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    _makeController.clear();
                  },
                  child: const Icon(Icons.clear),
                ),
              ),
              const SizedBox(height: 16),

              ///Model
              Text(
                'Model',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              AppTextInput(
                hintText: 'Enter model',
                errorText: _errorModel,
                focusNode: _focusModel,
                trailing: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    _modelController.clear();
                  },
                  child: const Icon(Icons.clear),
                ),
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                    context,
                    _focusModel,
                    _focusreg,
                  );
                },
                onChanged: (text) {
                  setState(() {
                    _errorModel =
                        UtilValidator.validate(_modelController.text, type: ValidateType.model);
                  });
                },
                controller: _modelController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),

              ///Registration
              Text(
                'Registration No',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              AppTextInput(
                hintText: 'Enter registration number',
                errorText: _errorRegis,
                onChanged: (text) {
                  setState(() {
                    _errorRegis = UtilValidator.validate(_registrationNoController.text,
                        type: ValidateType.registration);
                  });
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                    context,
                    _focusreg,
                    _focusColor,
                  );
                },
                trailing: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    _registrationNoController.clear();
                  },
                  child: const Icon(Icons.clear),
                ),
                controller: _registrationNoController,
                focusNode: _focusreg,
              ),
              const SizedBox(height: 16),

              ///Color
              Text(
                'Color',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              AppTextInput(
                hintText: 'Enter color',
                errorText: _errorColor,
                onChanged: (text) {
                  setState(() {
                    _errorColor =
                        UtilValidator.validate(_colorController.text, type: ValidateType.color);
                  });
                },
                onSubmitted: (text) {
                  UtilOther.hiddenKeyboard(context);
                },
                trailing: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    _colorController.clear();
                  },
                  child: const Icon(Icons.clear),
                ),
                controller: _colorController,
                focusNode: _focusColor,
              ),
              const SizedBox(height: 16),

              ///Category
              Text(
                'Category',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor.withOpacity(.07),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonFormField<String>(
                  value: _categoryValue,
                  decoration: const InputDecoration(
                    // labelText: 'Category',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  items: <String>['Compact', 'SUV', 'Luxury'].map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _categoryValue = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the category of the car';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16.0),

              ///Button
              AppButton(
                widget.car != null ? 'Save' : 'Add',
                mainAxisSize: MainAxisSize.max,
                onPressed: _submit,
                loading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
