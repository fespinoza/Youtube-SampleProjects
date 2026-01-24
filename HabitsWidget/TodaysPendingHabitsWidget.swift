import WidgetKit
import SwiftUI
import SwiftData
import DataModels
import DebugUI

// TODO: add interactivity

struct TodaysPendingHabitsProvider: TimelineProvider {
    func placeholder(in context: Context) -> TodaysPendingHabitsEntry {
        .init(
            date: Date(),
            habits: [
                .init(name: "Sample Habit #1"),
                .init(name: "Sample Habit #2"),
            ],
            totalHabits: 2
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (TodaysPendingHabitsEntry) -> ()) {
        completion(todaysDataAsEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [TodaysPendingHabitsEntry] = [todaysDataAsEntry()]
        let timeline = Timeline(entries: entries, policy: .after(.now.addingTimeInterval(60 * 60)))
        completion(timeline)
    }

    // MARK: - Private

    func todaysDataAsEntry() -> TodaysPendingHabitsEntry {
        TodaysPendingHabitsEntry.init(
            date: Date(),
            habits: loadTodaysData(),
            totalHabits: loadData().count
        )
    }

    /// Returns true if two dates are in the same calendar day.
    /// Uses the current Calendar and respects the user's locale/timezone.
    func isSameDay(_ lhs: Date, _ rhs: Date, calendar: Calendar = .current) -> Bool {
        calendar.isDate(lhs, inSameDayAs: rhs)
    }

    func loadTodaysData() -> [Habit] {
        let today = Date()
        let allHabits = loadData()

        return allHabits.filter { habit in
            guard let occurrences = habit.occurrences else { return false }

            return occurrences.contains { occurrence in
                Calendar.current.isDate(occurrence.date, inSameDayAs: today)
            } == false
        }
    }

    func loadData() -> [Habit] {
        let schema = Schema([
            Habit.self,
            Occurrence.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            let context = ModelContext(container)

            let descriptor = FetchDescriptor<Habit>(
                predicate: #Predicate<Habit> { $0.isArchived == false },
                sortBy: [SortDescriptor(\.sortOrder)])
            let habits = try context.fetch(descriptor)

            return habits
        } catch {
            return []
        }
    }
}

struct TodaysPendingHabitsEntry: TimelineEntry {
    let date: Date
    let habits: [Habit]
    let totalHabits: Int
}

struct TodaysPendingHabitsWidgetEntryView: View {
    var entry: TodaysPendingHabitsEntry
    @Environment(\.widgetFamily) private var widgetFamily

    var body: some View {
        if widgetFamily == .accessoryRectangular {
            AccessoryRectangular(
                pendingHabits: entry.habits.count,
                totalHabits: entry.totalHabits
            )
        } else {
            if entry.totalHabits == 0 {
                noHabitsFound
            } else {
                habitsPresent
            }
        }
    }

    var habitsPresent: some View {
        HStack(spacing: 12) {
            summary
                .frame(width: 80, alignment: .leading)
                .debugBackground(.red)

            Divider()

            Group {
                if entry.habits.count == 0 {
                    allHabitsCompleted
                } else {
                    habits
                        .debugBackground(.red)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .debugOverlay(.red, level: 0)
    }

    var allHabitsCompleted: some View {
        VStack(alignment: .leading) {
            Text("That's great 🎉")
                .bold()
                .foregroundStyle(.accent)

            Text("You are done for the day")
        }
        .font(.title3)
        .debugBorder(level: 1)
    }

    var noHabitsFound: some View {
        VStack {
            VStack {
                Text("🤔")
                    .font(.title)

                Text("You don’t have any habits yet,\nlet's get started")
                    .multilineTextAlignment(.center)
            }

            Spacer()

            Button("Create Habit", action: {})
                .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity)
        .debugBackground(.green, level: 1)
    }

    var summary: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text(entry.habits.count.formatted())
                    .foregroundStyle(Color.accent)
                    .font(.system(size: 40))
                    .widgetAccentable()

                Text("/\(entry.totalHabits)")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text("Today's Pending \(Text("Habits").foregroundStyle(Color.accent))")
                .font(.subheadline.bold())
                .widgetAccentable()
        }
        .frame(maxHeight: .infinity)
        .debugBackground(level: 1)
    }

    var habits: some View {
        VStack(alignment: .leading, spacing: 3) {
            ForEach(entry.habits.prefix(habitAmount)) { habit in
                row(for: habit)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .debugBackground(level: 1)
    }

    var habitAmount: Int {
        widgetFamily == .systemLarge ? 10 : 4
    }

    func row(for habit: Habit) -> some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 4)
                .stroke()
                .foregroundStyle(.secondary)
                .frame(width: 19, height: 19)

            Text(habit.name)
                .lineLimit(1)
                .font(.footnote)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .frame(height: 30)
        .debugBackground(.blue, level: 2)
    }
}

extension TodaysPendingHabitsWidgetEntryView {
    struct AccessoryRectangular: View {
        let pendingHabits: Int
        let totalHabits: Int

        var body: some View {
            VStack(alignment: .leading) {
                if totalHabits == 0 {
                    Text("No habits yet...")
                        .bold()
                } else if pendingHabits == 0 {
                    Text("\(totalHabits) habits completed!")
                        .bold()
                } else {
                    Text("Today's Pending Habits")
                        .font(.footnote)
                    Text("\(pendingHabits)/\(totalHabits)")
                        .bold()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct TodaysPendingHabitsWidget: Widget {
    let kind: String = "TodaysPendingHabitsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TodaysPendingHabitsProvider()) { entry in
            TodaysPendingHabitsWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                .debugColorEnabled()
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium, .systemLarge, .accessoryRectangular])
    }
}

let sampleHabits: [String] = [
    "📏 measure waist",
    "🇳🇴 Duolingo",
    "📚 Read",
    "🎬 YouTube",
    "🧑‍💻 Coding",
    "🍅 4 work pomodoros",
    "📝 Readwise",
    "🥗 Follow Diet",
    "💧Drink Enough Water",
    "🏃8000 Steps",
    "✍️ Journaling",
    "😴 sleep early (max 11pm)",
]

#Preview(as: .systemMedium) {
    TodaysPendingHabitsWidget()
} timeline: {
    TodaysPendingHabitsEntry(
        date: .now,
        habits: sampleHabits.map { .init(name: $0) },
        totalHabits: sampleHabits.count
    )

    TodaysPendingHabitsEntry(
        date: .now,
        habits: Array((sampleHabits.map { .init(name: $0) }).prefix(2)),
        totalHabits: sampleHabits.count
    )

    TodaysPendingHabitsEntry(
        date: .now,
        habits: [],
        totalHabits: sampleHabits.count
    )

    TodaysPendingHabitsEntry(
        date: .now,
        habits: [],
        totalHabits: 0
    )
}
