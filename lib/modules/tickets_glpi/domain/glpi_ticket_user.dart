enum TicketUserRole {
  requester,
  assignee,
  observer,
}

extension TicketUserRoleX on TicketUserRole {
  String get asString {
    switch (this) {
      case TicketUserRole.requester:
        return 'requester';
      case TicketUserRole.assignee:
        return 'assignee';
      case TicketUserRole.observer:
        return 'observer';
    }
  }
}

class GlpiTicketUser {
  final String userId;
  final TicketUserRole role;

  GlpiTicketUser({
    required this.userId,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'role': role.asString,
      };
}