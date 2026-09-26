import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/domain/entities/repo/repo.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

class RepoTabView extends StatelessWidget {
  const RepoTabView({super.key, required this.data});

  final SampleFeature data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, _) => const Divider(),
      itemCount: data.repositoryList?.length ?? 0,
      itemBuilder: (_, index) {
        final Repo? item = data.repositoryList?[index];
        return (item == null)
            ? Center(
                child: Text('txt_no_repository'.tr()),
              )
            : ListTile(
                title: Text(item.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.description ?? '-',
                      style: AppStyle.body2,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star_outline, size: 14),
                        Text(
                          ' ${item.totalStar ?? 0}  ',
                          style: AppStyle.body3,
                        ),
                        const Icon(Icons.remove_red_eye_outlined, size: 14),
                        Text(
                          ' ${item.totalWatch ?? 0}  ',
                          style: AppStyle.body3,
                        ),
                        const Icon(Icons.fork_right_outlined, size: 14),
                        Text(
                          ' ${item.totalFork ?? 0}  ',
                          style: AppStyle.body3,
                        ),
                      ],
                    )
                  ],
                ),
              );
      },
    );
  }
}
