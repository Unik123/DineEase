import 'package:dineease/model/profile/profile.dart';
import 'package:dineease/style/components/dialogs.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view/profile/our_team/add_our_team.dart';
import 'package:dineease/view/profile/our_team/edit_team_member.dart';
import 'package:dineease/view_model/profile/our_team_vm.dart';
import 'package:dineease/view_model/profile/profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurTeam extends StatefulWidget {
  const OurTeam({super.key});

  @override
  State<OurTeam> createState() => _OurTeamState();
}

class _OurTeamState extends State<OurTeam> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OurTeamViewModel>(context, listen: false).fetchTeams();
    });
  }

  @override
  Widget build(BuildContext context) {
    final teamVM = Provider.of<OurTeamViewModel>(context);
    final teams = teamVM.teams;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final profileVM = Provider.of<ProfileViewModel>(context, listen: false);
    final Profile user = profileVM.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meet Our Team", style: MyTextStyle.title),
        actions: [
          if (user.role == 'admin')
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.widthPadding * 1.3),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AddOurTeam();
                      },
                    ),
                  );
                },
                child: Container(
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.04,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: Center(
                    child: Text(
                      "Add",
                      style: MyTextStyle.body.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.screenPadding),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppConstants.verticalpadding * 9.5),
                Container(
                  height: 150,
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                          height: AppConstants.verticalpadding * 3.2),
                      Text(
                        teams.first.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyle.body.copyWith(fontSize: 20),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            teams.first.role,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: MyTextStyle.subtitle.copyWith(fontSize: 17),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Divider(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: teams.length - 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final member = teams[index + 1];
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                  height: AppConstants.verticalpadding * 3.5),
                              CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(member.image),
                              ),
                              const SizedBox(
                                  height: AppConstants.verticalpadding * 3.5),
                              Text(
                                member.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: MyTextStyle.body,
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Divider(),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    member.role,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: MyTextStyle.body,
                                  ),
                                  const SizedBox(width: 10),
                                  const Expanded(
                                    child: Divider(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return EditTeamMember(
                                          team: member,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  AppDialogs.showMyDialog(
                                    'Are you sure you want to delete this member?',
                                    context,
                                    () {
                                      teamVM.deleteTeamMember(
                                          member.id.toString());
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Center(
              child: CircleAvatar(
                radius: 53,
                backgroundImage: NetworkImage(teams.first.image),
              ),
            )
          ],
        ),
      ),
    );
  }
}
