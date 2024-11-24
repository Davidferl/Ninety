import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/main.dart';
import 'package:bonne_reponse/src/authentication/hooks/use_authentication.dart';
import 'package:bonne_reponse/src/group/application/group_service.dart';
import 'package:bonne_reponse/src/group/domain/group.dart';
import 'package:bonne_reponse/src/group/domain/objective.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/widgets/bottom_button.dart';
import 'package:bonne_reponse/src/view/widgets/custom_text_input.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

enum Values { continuous, discrete }

String? validateTitle(String? value) {
  if (value == null || value.isEmpty) {
    return "The title is required.";
  }

  if (value.length > 31) {
    return "The title is too long.";
  }

  return null;
}

String? validateContinuousObjective(String? value) {
  if (value == null || value.isEmpty) {
    return "Required.";
  }

  return null;
}

String? validateContinuousUnit(String? value) {
  if (value == null || value.isEmpty) {
    return "Required.";
  }

  return null;
}

String? validateDiscreteAmount(String? value) {
  if (value == null || value.isEmpty) {
    return "Required.";
  }

  return null;
}

class GroupViewer extends HookWidget {
  const GroupViewer({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    final GroupService groupService = locator<GroupService>();

    final auth = useAuthentication();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final dropdownActive = useState(false);

    final selectedIndex = useState(Values.continuous);

    final titleController = useTextEditingController();
    final continuousObjectiveController = useTextEditingController();
    final continuousUnitController = useTextEditingController();
    final discreteAmountController = useTextEditingController();

    Future<void> createGroup() async {
      if (selectedIndex.value == Values.continuous) {
        if (formKey.currentState!.validate()) {
          final title = titleController.text;
          final objective = continuousObjectiveController.text;
          final unit = continuousUnitController.text;

          await groupService.addMember(group.groupId, auth.user!.uid, title,
              double.parse(objective), unit, QuantityType.continuous);
        }
      } else {
        if (formKey.currentState!.validate()) {
          final title = titleController.text;
          final objective = discreteAmountController.text;

          await groupService.addMember(group.groupId, auth.user!.uid, title,
              double.parse(objective), '', QuantityType.discrete);
        }
      }
      context.goNamed(Routes.home.name);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () => context.pop(''),
                            icon: const Icon(Icons.chevron_left, size: 30)),
                        SectionName(name: group.title),
                        IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.more_horiz))
                      ],
                    ),
                    const Divider(
                      color: kcDivider,
                      thickness: 1,
                    ),
                    verticalSpace(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.what_is_this_group,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: kcSecondaryVariant,
                                  ),
                        ),
                        verticalSpace(4),
                        Text(
                          group.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: kcDarkGray,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    verticalSpace(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.create_an_objective,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: kcSecondaryVariant,
                                  ),
                        ),
                        verticalSpace(4),
                        Text(
                          AppLocalizations.of(context)!
                              .create_an_objective_description,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: kcDarkGray,
                                  fontWeight: FontWeight.w500),
                        ),
                        verticalSpace(16),
                        CustomTextInput(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          labelText: AppLocalizations.of(context)!
                              .create_objective_prompt,
                          controller: titleController,
                          validator: validateTitle,
                        ),
                        verticalSpace(16),
                        Column(
                          children: [
                            ExpansionPanelList(
                              expandIconColor: kcSecondaryVariant,
                              expansionCallback: (panelIndex, isExpanded) {
                                dropdownActive.value = !dropdownActive.value;
                              },
                              children: <ExpansionPanel>[
                                ExpansionPanel(
                                    headerBuilder: (context, isExpanded) {
                                      return ListTile(
                                        iconColor: kcSecondaryVariant,
                                        title: Text(
                                          AppLocalizations.of(context)!
                                              .create_objective_meaning,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: kcSecondaryVariant,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      );
                                    },
                                    body: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 0, 16, 16),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .create_objective_meaning_description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: kcDarkGray,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    isExpanded: dropdownActive.value,
                                    canTapOnHeader: true)
                              ],
                            ),
                          ],
                        ),
                        verticalSpace(20),
                        Column(
                          children: <Widget>[
                            ListTile(
                              minVerticalPadding: 0,
                              title: Text(
                                  AppLocalizations.of(context)!.continuous,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: kcDarkGray,
                                          fontWeight: FontWeight.w500)),
                              leading: Radio<Values>(
                                value: Values.continuous,
                                groupValue:
                                    selectedIndex.value == Values.continuous
                                        ? Values.continuous
                                        : Values.discrete,
                                onChanged: (Values? value) {
                                  selectedIndex.value = Values.continuous;
                                },
                              ),
                            ),
                            ListTile(
                              title: Text(
                                  AppLocalizations.of(context)!.discrete,
                                  style: const TextStyle(
                                      color: kcDarkGray,
                                      fontWeight: FontWeight.w500)),
                              leading: Radio<Values>(
                                value: Values.discrete,
                                groupValue:
                                    selectedIndex.value == Values.continuous
                                        ? Values.continuous
                                        : Values.discrete,
                                onChanged: (Values? value) {
                                  selectedIndex.value = Values.discrete;
                                },
                              ),
                            ),
                          ],
                        ),
                        selectedIndex.value == Values.continuous
                            ? Row(
                                children: [
                                  Expanded(
                                    flex:
                                        3, // Number of times input takes 3/4 of the space
                                    child: CustomTextInput(
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      labelText: AppLocalizations.of(context)!
                                          .create_objective_continuous_objective,
                                      controller: continuousObjectiveController,
                                      validator: validateContinuousObjective,
                                    ),
                                  ),
                                  horizontalSpace(16),
                                  Expanded(
                                    flex:
                                        2, // Objective input takes 1/4 of the space
                                    child: CustomTextInput(
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.number,
                                      labelText: AppLocalizations.of(context)!
                                          .create_objective_continuous_unit,
                                      controller: continuousUnitController,
                                      validator: validateContinuousUnit,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    flex:
                                        1, // Objective input takes 1/4 of the space
                                    child: CustomTextInput(
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.number,
                                      labelText: AppLocalizations.of(context)!
                                          .create_objective_discrete_objective,
                                      controller: discreteAmountController,
                                      validator: validateDiscreteAmount,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BottomButton(
                  onPressed: () => createGroup(),
                  title: AppLocalizations.of(context)!.join_group,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


//Title
//unit KM
//quantityType continuous