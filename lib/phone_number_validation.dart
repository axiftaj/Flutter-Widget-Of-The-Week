
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';


class PhoneNumberValidation extends StatefulWidget {
  const PhoneNumberValidation({Key? key}) : super(key: key);

  @override
  State<PhoneNumberValidation> createState() => _PhoneNumberValidationState();
}

class _PhoneNumberValidationState extends State<PhoneNumberValidation> {

  late PhoneController controller;
  bool outlineBorder = true;
  bool mobileOnly = true;
  bool shouldFormat = true;
  bool isCountryChipPersistent = false;
  bool withLabel = true;
  bool useRtl = false;
  CountrySelectorNavigator selectorNavigator =
  const CountrySelectorNavigator.searchDelegate();
  final formKey = GlobalKey<FormState>();
  final phoneKey = GlobalKey<FormFieldState<PhoneNumber>>();

  @override
  initState() {
    super.initState();
    controller = PhoneController(null);
    controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Phone_form_field'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SwitchListTile(
                      value: outlineBorder,
                      onChanged: (v) => setState(() => outlineBorder = v),
                      title: const Text('Outlined border'),
                    ),
                    SwitchListTile(
                      value: withLabel,
                      onChanged: (v) => setState(() => withLabel = v),
                      title: const Text('Label'),
                    ),
                    SwitchListTile(
                      value: isCountryChipPersistent,
                      onChanged: (v) =>
                          setState(() => isCountryChipPersistent = v),
                      title: const Text('Persistent country chip'),
                    ),
                    SwitchListTile(
                      value: mobileOnly,
                      onChanged: (v) => setState(() => mobileOnly = v),
                      title: const Text('Mobile phone number only'),
                    ),
                    SwitchListTile(
                      value: shouldFormat,
                      onChanged: (v) => setState(() => shouldFormat = v),
                      title: const Text('Should format'),
                    ),
                    SwitchListTile(
                      value: useRtl,
                      onChanged: (v) {
                        setState(() => useRtl = v);
                      },
                      title: const Text('RTL'),
                    ),
                    ListTile(
                      title: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text('Country selector: '),
                          DropdownButton<CountrySelectorNavigator>(
                            value: selectorNavigator,
                            onChanged: (CountrySelectorNavigator? value) {
                              if (value != null) {
                                setState(() => selectorNavigator = value);
                              }
                            },
                            items: const [
                              DropdownMenuItem(
                                value: CountrySelectorNavigator.bottomSheet(),
                                child: Text('Bottom sheet'),
                              ),
                              DropdownMenuItem(
                                value: CountrySelectorNavigator
                                    .draggableBottomSheet(),
                                child: Text('Draggable modal sheet'),
                              ),
                              DropdownMenuItem(
                                value:
                                CountrySelectorNavigator.modalBottomSheet(
                                  favorites: [IsoCode.US, IsoCode.BE],
                                ),
                                child: Text('Modal sheet'),
                              ),
                              DropdownMenuItem(
                                value:
                                CountrySelectorNavigator.dialog(width: 720),
                                child: Text('Dialog'),
                              ),
                              DropdownMenuItem(
                                value:
                                CountrySelectorNavigator.searchDelegate(),
                                child: Text('Page'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Form(
                      key: formKey,
                      child: PhoneFieldView(
                        inputKey: phoneKey,
                        controller: controller,
                        selectorNavigator: selectorNavigator,
                        withLabel: withLabel,
                        outlineBorder: outlineBorder,
                        isCountryChipPersistent: isCountryChipPersistent,
                        mobileOnly: mobileOnly,
                        shouldFormat: shouldFormat,
                        useRtl: useRtl,

                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(controller.value.toString()),
                    ElevatedButton(
                      onPressed:(){
                        if(formKey.currentState!.validate()){
                          print('enter phone number');
                        }

                        if(phoneKey.currentState!.validate()){
                          print('enter validation');
                        }
                      },
                      child: Text('Validation') ,
                    ),
                    Text('is valid mobile number '
                        '${controller.value?.isValid(type: PhoneNumberType.mobile) ?? 'false'}'),
                    Text(
                        'is valid fixed line number ${controller.value?.isValid(type: PhoneNumberType.fixedLine) ?? 'false'}'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: controller.value == null
                          ? null
                          : () => controller.reset(),
                      child: const Text('reset'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => controller.selectNationalNumber(),
                      child: const Text('Select national number'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => controller.value = PhoneNumber.parse(
                        '699999999',
                        destinationCountry: IsoCode.FR,
                      ),
                      child: const Text('Set +33 699 999 999'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class PhoneFieldView extends StatelessWidget {
  final Key inputKey;
  final PhoneController controller;
  final CountrySelectorNavigator selectorNavigator;
  final bool withLabel;
  final bool outlineBorder;
  final bool shouldFormat;
  final bool isCountryChipPersistent;
  final bool mobileOnly;
  final bool useRtl;

  const PhoneFieldView({
    Key? key,
    required this.inputKey,
    required this.controller,
    required this.selectorNavigator,
    required this.withLabel,
    required this.outlineBorder,
    required this.shouldFormat,
    required this.isCountryChipPersistent,
    required this.mobileOnly,
    required this.useRtl,
  }) : super(key: key);

  PhoneNumberInputValidator? _getValidator() {
    List<PhoneNumberInputValidator> validators = [];
    if (mobileOnly) {
      validators.add(PhoneValidator.validMobile());
    } else {
      validators.add(PhoneValidator.valid());
    }
    return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: PhoneFormField(
        key: inputKey,
        controller: controller,
        shouldFormat: shouldFormat && !useRtl,
      //  autofocus: true,
        autofillHints: const [AutofillHints.telephoneNumber],
        countrySelectorNavigator: selectorNavigator,
        defaultCountry: IsoCode.US,
        decoration: InputDecoration(
          fillColor: Colors.red,
          label: withLabel ? const Text('Phone') : null,
          border: outlineBorder ? const OutlineInputBorder() : const UnderlineInputBorder(),
          hintText: withLabel ? '' : 'Phone',
        ),
        enabled: true,
        showFlagInInput: true,
        validator: _getValidator(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Theme.of(context).colorScheme.primary,
        // ignore: avoid_print
        onSaved: (p) => print('saved $p'),
        // ignore: avoid_print
        onChanged: (p) => print('changed $p'),
        isCountryChipPersistent: isCountryChipPersistent,
      ),
    );
  }
}